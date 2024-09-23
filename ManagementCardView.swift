//
//  ManagementCardView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 01/03/24.
//

import SwiftUI

struct ManagementCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
                //.frame(width: cardAndImageWidth, height: cardHeight)
                .background(SwiftUI.Color.white)
            VStack(alignment: .leading, spacing: 10) {
         
                LazyVStack(alignment: .leading, spacing: 2) {
                    Text("No Name")
                        .font(.custom("Avenir", size: 14))
                        .fontWeight(.bold)
                    Text("No Address")
                        .font(.custom("Avenir", size: 12))
                        .foregroundColor(SwiftUI.Color.gray)
                }
                .padding(.horizontal,12)
                .padding(.bottom,11)
            }
            //.frame(width: cardAndImageWidth, height: cardHeight)
            .cornerRadius(cornerRadius)
        }
    }
   // private let cardAndImageWidth: CGFloat = 170
    private let cardHeight: CGFloat = 174
   // private let imageHeight: CGFloat = 116
    private let cornerRadius: CGFloat = 5
}
