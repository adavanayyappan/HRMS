//
//  ClaimListView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/10/24.
//

import SwiftUI

struct ClaimListView: View {
    
    var item: ClaimResponse.Claim
    var convertedDate : String = ""
    var convertedMonth : String = ""
    
    init(item: ClaimResponse.Claim) {
        self.item = item
        guard let date = Dater.shared.date(from: item.claimCreatedOn ?? "", format: "yyyy-MM-dd HH:mm:ss.SSS") else {
            return
        }
        self.convertedDate = Dater.shared.string(from: date, format: "dd") ?? ""
        self.convertedMonth = Dater.shared.string(from: date, format: "MMM") ?? ""
    }
    
    var body: some View {
        ZStack{
            HStack(spacing: 20) {
                VStack {
                    VStack {
                        Text(convertedMonth)
                            .font(Fonts.custom(Fonts.CustomFont.lexenddeca, size: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    .frame(width: 70, height: 20)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.buttonBackgroundColor)
                    )
                    .padding(.top, 1)
                    
                    Text(convertedDate)
                        .foregroundColor(.darkGray)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 25))
                    
                    Spacer()
                    
                }
                .frame(width: 70, height: 70)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                )
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 20,
                        bottom: 10,
                        trailing: 0
                    )
                )
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.claimGroupName ?? "")
                        .foregroundColor(.darkGray)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        .padding(.top, 10)
                    
                    Text("Claim Amount: \(item.claimAmount ?? "")")
                        .foregroundColor(.gray)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 11))
                        .padding(.top, 5)
                    
                    if item.claimStatus == "Approved" {
                        Text(item.claimStatus ?? "")
                            .foregroundColor(.green)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                            .padding(.bottom, 5)
                    } else if item.claimStatus == "Pending" {
                        Text(item.claimStatus ?? "")
                            .foregroundColor(.yellow)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                            .padding(.bottom, 5)
                    } else {
                        Text(item.claimStatus ?? "")
                            .foregroundColor(.red)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                            .padding(.bottom, 5)
                    }
                    
                    if let remark = item.claimRemarks {
                        Text("Remark: \(remark)")
                            .foregroundColor(.gray)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                            .padding(.bottom, 10)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 5)
                   .fill(Color.white)
                   .shadow(color: .gray, radius: 2, x: 0, y: 2)
       )
        .padding(
            EdgeInsets(
                top: 5,
                leading: 10,
                bottom: 5,
                trailing: 10
            )
        )
    }
}
