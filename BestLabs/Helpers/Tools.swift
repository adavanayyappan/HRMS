//
//  Tools.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 17/07/24.
//

import UIKit

class Tools {
    
    static func filePath(forResourceName name: String, withExtension ext: String) -> String? {
        let filePath = Bundle.main.path(forResource: name, ofType: ext)
        if filePath == nil {
            print("Could not find '\(name).\(ext)' in bundle.")
        }
        return filePath
    }
    
    static func convertUIImageToBitmapRGBA8(_ image: UIImage) -> [UInt8]? {
        guard let imageRef = image.cgImage else { return nil }
        
        guard let context = newBitmapRGBA8Context(from: imageRef) else {
            return nil
        }
        
        let width = imageRef.width
        let height = imageRef.height
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        context.draw(imageRef, in: rect)
        
        guard let bitmapData = context.data else {
            print("Error getting bitmap pixel data")
            return nil
        }
        
        let bytesPerRow = context.bytesPerRow
        let bufferLength = bytesPerRow * height
        var newBitmap = [UInt8](repeating: 0, count: bufferLength)
        
        for i in 0..<bufferLength {
            newBitmap[i] = bitmapData.load(fromByteOffset: i, as: UInt8.self)
        }
        
        return newBitmap
    }
    
    private static func newBitmapRGBA8Context(from image: CGImage) -> CGContext? {
        let bitsPerPixel = 32
        let bitsPerComponent = 8
        let bytesPerPixel = bitsPerPixel / bitsPerComponent
        let width = image.width
        let height = image.height
        let bytesPerRow = width * bytesPerPixel
        let bufferLength = bytesPerRow * height
        
        guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
            print("Error allocating color space RGB")
            return nil
        }
        
        let bitmapData = malloc(bufferLength)
        guard bitmapData != nil else {
            print("Error allocating memory for bitmap")
            return nil
        }
        
        guard let context = CGContext(data: bitmapData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            free(bitmapData)
            print("Bitmap context not created")
            return nil
        }
        
        return context
    }
    
    static func scaleImage(_ image: UIImage, toSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}

