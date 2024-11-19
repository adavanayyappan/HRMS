//
//  ClaimResponse.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 24/10/24.
//


import Foundation

// MARK: - ClaimResponse
struct ClaimResponse: Codable {
    let status: String
    let message: String
    let result: [Claim]?
    let totalRecords: Int?
    let totalPages: Int?
    
    // MARK: - Claim
    struct Claim: Codable, Identifiable {
        let id: UUID = UUID()
        let claimLimitName: String?
        let claimGroupID: Int?
        let claimGroupCode: String?
        let claimGroupName: String?
        let claimID: Int?
        let claimEmpID: Int?
        let claimLimitPkID: Int?
        let claimGroupPkID: Int?
        let claimAmount: String?
        let claimRemarks: String?
        let claimAttachment: String?
        let claimStatus: String?
        let claimCreatedOn: String? // You might want to convert this to Date later
        
        enum CodingKeys: String, CodingKey {
                case claimLimitName = "ClaimLimitName"
                case claimGroupID = "ClaimGroupID"
                case claimGroupCode = "ClaimGroupCode"
                case claimGroupName = "ClaimGroupName"
                case claimID = "ClaimID"
                case claimEmpID = "ClaimEmpID"
                case claimLimitPkID = "ClaimLimitPkID"
                case claimGroupPkID = "ClaimGroupPkID"
                case claimAmount = "ClaimAmount"
                case claimRemarks = "ClaimRemarks"
                case claimAttachment = "ClaimAttachment"
                case claimStatus = "ClaimStatus"
                case claimCreatedOn = "ClaimCreatedOn"
            }
    }
}
