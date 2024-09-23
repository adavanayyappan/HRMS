//
//  ClaimManagementView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI

struct ClaimManagementView_Previews: PreviewProvider {
    static var previews: some View {
        ClaimManagementView()
    }
}

struct ClaimManagementView: View {
    @State private var colorCards: [ColorCard] = ColorCard.sampleData


    var body: some View {
        VStack {
            HStack {
                Text("Claim Summary")
                    .foregroundColor(.black)
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                    .padding(
                        EdgeInsets(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
                CircleButton()
            }
            
    
            List {
                ForEach(colorCards) { colorCard in
                    LeavebalancecardView(colorCard: colorCard)
                }
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
        }
        .foregroundColor(.black)
    }
}
