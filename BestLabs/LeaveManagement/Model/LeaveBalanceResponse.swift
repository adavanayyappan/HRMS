//
//  LeaveBalanceResponse.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/09/24.
//
import Foundation

// MARK: - Response
struct LeaveBalanceResponse: Codable {
    let status: String
    let message: String
    let result: [LeaveBalance]
}

// MARK: - LeaveBalance
struct LeaveBalance: Codable, Identifiable, Equatable {
    let id: UUID = UUID()
    let label: String
    let value: Int
    let balanceLeave: Int

    enum CodingKeys: String, CodingKey {
        case label
        case value
        case balanceLeave = "balanceleave"
    }
}
