//
//  BaseStringConverter.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 25/07/24.
//

import Foundation

class BaseStringConverter {
    
    static func intToBase64String(_ number: Int) -> String? {
        // Convert the integer to a string
        let numberString = String(number)
        
        // Convert the string to data using UTF-8 encoding
        guard let data = numberString.data(using: .utf8) else { return nil }
        
        // Encode the data to a Base64 string
        let base64String = data.base64EncodedString()
        
        return base64String
    }

}
