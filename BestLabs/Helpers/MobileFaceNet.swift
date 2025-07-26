import Foundation
import TensorFlowLite
import UIKit

class MobileFaceNet {
    private var interpreter: Interpreter!
    
    private let modelFileName = "MobileFaceNet"
    private let modelFileType = "tflite"
    private let imageWidth = 112
    private let imageHeight = 112
    private let embeddingsSize = 192
    
    init?() {
        guard let modelPath = Bundle.main.path(forResource: modelFileName, ofType: modelFileType) else {
            print("Failed to load model file with name: \(modelFileName).\(modelFileType)")
            return nil
        }
        
        var options = Interpreter.Options()
        options.threadCount = 4
        
        do {
            interpreter = try Interpreter(modelPath: modelPath, options: options)
            try interpreter.allocateTensors()
        } catch {
            print("Failed to create or allocate interpreter: \(error)")
            return nil
        }
    }
    
    func compare(image1: UIImage, with image2: UIImage) -> Float? {
        guard let imageScale1 = Tools.scaleImage(image1, toSize: CGSize(width: imageWidth, height: imageHeight)),
              let imageScale2 = Tools.scaleImage(image2, toSize: CGSize(width: imageWidth, height: imageHeight)),
              let data = dataWithProcess(image1: imageScale1, image2: imageScale2) else {
            return nil
        }
        
        do {
            let inputTensor = try interpreter.input(at: 0)
            try interpreter.copy(data, toInputAt: 0)
            try interpreter.invoke()
            let outputTensor = try interpreter.output(at: 0)
            let outputData = outputTensor.data
            
            let output = UnsafeMutablePointer<Float>.allocate(capacity: 2 * embeddingsSize)
            outputData.withUnsafeBytes { (bufferPointer: UnsafeRawBufferPointer) in
                if let baseAddress = bufferPointer.baseAddress {
                    memcpy(output, baseAddress, MemoryLayout<Float>.size * 2 * embeddingsSize)
                }
            }

            l2Normalize(embeddings: output, epsilon: 1e-10)
            let result = evaluate(embeddings: output)

            output.deallocate()

            return result
        } catch {
            print("Failed during inference: \(error)")
            return nil
        }
    }
    
    private func dataWithProcess(image1: UIImage, image2: UIImage) -> Data? {
        guard let imageData1 = Tools.convertUIImageToBitmapRGBA8(image1),
              let imageData2 = Tools.convertUIImageToBitmapRGBA8(image2) else {
            return nil
        }
        
        var floats = [Float](repeating: 0, count: 2 * imageWidth * imageHeight * 3)
        let inputMean: Float = 127.5
        let inputStd: Float = 128.0
        var k = 0
        
        for i in 0..<2 {
            let imageData = i == 0 ? imageData1 : imageData2
            let size = imageWidth * imageHeight * 4
            for j in 0..<size {
                if j % 4 == 3 {
                    continue
                }
                floats[k] = (Float(imageData[j]) - inputMean) / inputStd
                k += 1
            }
        }
        
        return Data(bytes: floats, count: floats.count * MemoryLayout<Float>.size)
    }
    
    private func l2Normalize(embeddings: UnsafeMutablePointer<Float>, epsilon: Float) {
            let embeddingsSize = 192
            for i in 0..<2 {
                var squareSum: Float = 0
                for j in 0..<embeddingsSize {
                    squareSum += pow(embeddings[i * embeddingsSize + j], 2)
                }
                let xInvNorm = sqrt(max(squareSum, epsilon))
                for j in 0..<embeddingsSize {
                    embeddings[i * embeddingsSize + j] = embeddings[i * embeddingsSize + j] / xInvNorm
                }
            }
        }

    private func evaluate(embeddings: UnsafeMutablePointer<Float>) -> Float {
        let sim = cosineSimilarity(embeddings, embeddings.advanced(by: embeddingsSize))
        return sim // Value from -1 (opposite) to 1 (same)
    }
    
    private func cosineSimilarity(_ a: UnsafePointer<Float>, _ b: UnsafePointer<Float>) -> Float {
        var dot: Float = 0
        var normA: Float = 0
        var normB: Float = 0
        
        for i in 0..<embeddingsSize {
            dot += a[i] * b[i]
            normA += a[i] * a[i]
            normB += b[i] * b[i]
        }
        
        return dot / (sqrt(normA) * sqrt(normB))
    }
}

