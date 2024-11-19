//
//  LeaveTypeResponse.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/09/24.
//

// MARK: - Response
struct LeaveTypeResponse: Codable {
    let status: String
    let message: String
    let result: [LeaveType]
}

// MARK: - LeaveType
struct LeaveType: Codable {
    let value: Int
    let label: String
}
