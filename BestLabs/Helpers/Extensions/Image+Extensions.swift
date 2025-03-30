//
//  Image+Extensions.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 28/06/24.
//

import SwiftUI

extension Image {
    static let logo = Image("logo")
    static let placeholder = Image("placeholder")
    static let profileIcon = Image("profile_icon")
    static let splashscreen = Image("splashscreen")
    static let dashboardBg = Image("dashboradbackground")
    static let profile = Image("profile")
    static let timesheet = Image("timesheet")
    static let claim = Image("claim")
    static let leave = Image("leave")
    static let facescan = Image("facescan")
    static let clock = Image("clock")
    static let checkout = Image("checkout")
    static let workinghrs = Image("workinghrs")
}

extension Color {
    static let colorPrimary = Color(hex: "#07162F")
    static let colorPrimaryDark = Color(hex: "#393e46")
    static let textColor = Color(hex: "#222222")
    static let buttonBackgroundColor = Color(hex: "#081A30")
    static let colorAccent = Color(hex: "#07162F")
    static let gray = Color(hex: "#5c636e")
    static let darkGray = Color(hex: "#393e46")
    static let teal200 = Color(hex: "#FF03DAC5")
    static let black = Color(hex: "#FF000000")
    static let white = Color(hex: "#FFFFFFFF")
    static let unselectedIconColor = Color(hex: "#808080")
    static let cardBackgroundColor = Color(hex: "#F6F6f6")
    static let timeColor = Color(hex: "#111F27")
    static let timeTextColor = Color(hex: "#203444")
}

extension Color {
    // Helper initializer to create a Color from a hex string
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
