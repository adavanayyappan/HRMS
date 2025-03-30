//
//  LoginUserModel.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 28/06/24.
//

import Foundation

struct ForgotPasswordModel: Codable {
    let status: String
    let message: String?
    let temp_otp: String?
}

struct ForgotPasswordRequest: Encodable {
    let empEmailId: String
}

struct ResetPasswordModel: Codable {
    let status: String
    let message: String?
}


