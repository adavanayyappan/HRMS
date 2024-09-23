//
//  TimeEntryResponse.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 29/06/24.
//

import Foundation

struct TimeEntryResponse: Codable {
    let status: String
    let message: String
    let result: [TimeEntry]
}

struct TimeEntry: Codable, Identifiable {
    let id: UUID = UUID()
    let dateFormat: String
    let date: String
    let day: String
    let month: String
    let startTime: String
    let endTime: String?
    let totalHours: String?
    
    enum CodingKeys: String, CodingKey {
        case dateFormat = "dateformat"
        case date
        case day
        case month
        case startTime = "satrtTime"
        case endTime
        case totalHours
    }
}


