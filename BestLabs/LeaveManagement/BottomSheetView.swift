//
//  BottomSheetView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 01/11/24.
//

import SwiftUI

struct BottomSheetView: View {
    var onApprove: () -> Void
    var onReject: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    onApprove()
                }) {
                    Text("Approve")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        .cornerRadius(8)
                }
                
                Spacer()

                Button(action: {
                    onReject()
                }) {
                    Text("Reject")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

