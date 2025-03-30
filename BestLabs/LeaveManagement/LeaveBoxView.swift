//
//  LeaveBoxView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 26/09/24.
//

import SwiftUI

struct LeaveBoxView: View {
    
    var item: LeaveBalance
    @Binding var selectedItem: LeaveBalance?
    
    init(item: LeaveBalance, selectedItem: Binding<LeaveBalance?>) {
        self.item = item
        self._selectedItem = selectedItem
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 20) {
                Text("\(item.balanceLeave)")
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 22))
                    .foregroundColor(selectedItem == item ? .white : .primarycolor)
                
                Text(item.label)
                    .multilineTextAlignment(.center)
                    .font(Fonts.custom(Fonts.CustomFont.lexenddeca, size: 10))
                    .foregroundColor(selectedItem == item ? .white : .primarycolor)
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
        .frame(width: 100, height: 100)
        .background(
               RoundedRectangle(cornerRadius: 5)
                .fill(selectedItem == item ? .primarycolor : .white)
                   .shadow(color: .gray, radius: 2, x: 0, y: 2)
       )
    }
}
