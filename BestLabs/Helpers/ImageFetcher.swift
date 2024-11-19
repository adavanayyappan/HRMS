//
//  ImageFetcher.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 17/07/24.
//

import UIKit

class ImageFetcher {
    static func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
    
    static func uploadImage(url: URL, image: UIImage, fileName: String = "face_image", parameters: [String: String], headers: [String: String], completion: @escaping (Result<Data, Error>) -> Void) {
            // Create the URLRequest object
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Define the boundary and set the content type
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            // Set custom headers
            for (headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
            
            // Create the HTTP body
            let httpBody = createMultipartBody(parameters: parameters, boundary: boundary, image: image)
            request.httpBody = httpBody
            
            // Create the URLSession and perform the request
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            task.resume()
        }
        
    static func createMultipartBody(parameters: [String: String], boundary: String, image: UIImage, fileName: String = "face_image") -> Data {
            var body = Data()
            
            // Append parameters
            for (key, value) in parameters {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
            
            // Append image data
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(fileName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
            
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            return body
        }
}

// Data extension to append strings to Data
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

