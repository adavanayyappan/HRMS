//
//  NetworkManager.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 28/06/24.
//

import SwiftUI
import Combine

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: LocalizedError {
    case badURL
    case requestFailed
    case serverError(statusCode: Int)
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL."
        case .requestFailed:
            return "Request failed."
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)."
        case .decodingError:
            return "Failed to decode the response."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(
        url: URL,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: Data? = nil,
        responseType: T.Type
    ) -> AnyPublisher<T, Error> {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpBody = body
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.requestFailed
                }
                switch httpResponse.statusCode {
                case 200...299:
                    return result.data
                case 400...499:
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                case 500...599:
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                default:
                    throw NetworkError.unknownError
                }
            }
            .decode(type: responseType, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let error = error as? NetworkError {
                    return error
                } else if error is DecodingError {
                    return .decodingError
                } else {
                    return .unknownError
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Convert form data to application/x-www-form-urlencoded format
    func createFormBody(from parameters: [String: String]) -> Data? {
        var components: [String] = []
        for (key, value) in parameters {
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            components.append("\(encodedKey)=\(encodedValue)")
        }
        let bodyString = components.joined(separator: "&")
        return bodyString.data(using: .utf8)
    }
}

