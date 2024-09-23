//
//  PunchStatusResponse.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 24/07/24.
//

import Foundation

struct PunchStatusResponse: Codable {
    let status: String
    let message: String
    let satrtTime: String
    let endTime: String
    let totalHrs: String
}
