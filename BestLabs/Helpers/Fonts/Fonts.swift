//
//  Fonts.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 22/06/24.
//

import SwiftUI

struct Fonts {
    struct CustomFont {
        static let brownBold = "brownbold"
        static let lexenddeca = "lexenddeca"
    }

    // Example for adding sizes
    static func custom(_ name: String, size: CGFloat) -> Font {
        return Font.custom(name, size: size)
    }
}

