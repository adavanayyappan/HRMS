//
//  CardView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 21/02/24.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        HStack {
            let data = ["21 Jan 24", "09.00 AM", "05.00 AM","08.00 Working HRS"]
            ForEach(data, id: \.self) { item in
                Text(item)
                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 100)
        .background(
         RoundedRectangle(cornerRadius: 25)
             .fill(Color.white)
             .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
    }
}


