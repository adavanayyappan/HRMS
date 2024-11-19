//
//  ClaimTypeResponse.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 24/10/24.
//
import Foundation

// MARK: - ClaimTypeResponse
struct ClaimTypeResponse: Codable {
    let status: String
    let message: String
    let result: [ClaimType]
}

// MARK: - ClaimType
struct ClaimType: Codable, Identifiable, Equatable {
    let id: UUID = UUID()
    let value: Int
    let label: String
}
