//
//  ColorCard.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 21/02/24.
//

import Foundation

struct ColorCard: Identifiable {
    let id = UUID()
    var theme: Theme
}

extension ColorCard {
    static let sampleData: [ColorCard] = [
        ColorCard(
            theme: Theme.allCases[0]
        ),
        ColorCard(
            theme: Theme.allCases[1]
        ),
        ColorCard(
            theme: Theme.allCases[2]
        ),
        ColorCard(
            theme: Theme.allCases[3]
        ),
        ColorCard(
            theme: Theme.allCases[4]
        )
    ]
}
