//
//  ClaimBoxView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/10/24.
//

import SwiftUI

struct ClaimBoxView: View {
    
    var item: ClaimType
    @Binding var selectedItem: ClaimType?
    
    init(item: ClaimType, selectedItem: Binding<ClaimType?>) {
        self.item = item
        self._selectedItem = selectedItem
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 20) {
                Text(item.label)
                    .multilineTextAlignment(.center)
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 10))
                    .foregroundColor(selectedItem == item ? .white : .buttonBackgroundColor)
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
            }
        }
        .frame(width: 100, height: 80)
        .background(
               RoundedRectangle(cornerRadius: 5)
                .fill(selectedItem == item ? Color.buttonBackgroundColor : .white)
                   .shadow(color: .gray, radius: 2, x: 0, y: 2)
       )
    }
}
