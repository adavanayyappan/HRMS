//
//  LeaveRequestListResponse.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 10/10/24.
//

import Foundation

struct LeaveRequestListResponse: Codable {
    let status: String
    let message: String
    let result: [Leave]?
    let totalRecords: Int?
    let totalPages: Int?

    struct Leave: Codable, Identifiable {
        let id: UUID = UUID()
        let leaveGroupCode: String?
        let LeaveGroupName: String?
        let leaveID: Int?
        let leaveClientID: Int?
        let leaveEmpID: Int?
        let leaveFrom: String?
        let leaveTo: String?
        let leaveNoOfDays: Int?
        let leaveRemarks: String?
        let leaveAttachment: String?
        let leaveStatus: String?
        let leaveCreatedOn: String?
    }
}

