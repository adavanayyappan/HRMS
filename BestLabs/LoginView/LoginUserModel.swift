//
//  LoginUserModel.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 28/06/24.
//

import Foundation

struct LoginUserModel: Codable {
    let status: String
    let result: LoginResult
}

struct LoginResult: Codable {
    let employeeID: Int
    let employeeCode: String
    let employeeName: String
    let employeeClientID: Int
    let employeeCompanyID: Int
    let faceImage: String
    let allowApprove: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case employeeID = "EmployeeID"
        case employeeCode = "EmployeeCode"
        case employeeName = "EmployeeName"
        case employeeClientID = "EmployeeClientID"
        case employeeCompanyID = "EmployeeCompanyID"
        case faceImage
        case token
        case allowApprove
    }
}

struct LoginRequest: Encodable {
    let userName: String
    let password: String
}


