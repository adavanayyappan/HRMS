//
//  LeavebalancecardView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import SwiftUI

struct LeavebalancecardView_Previews: PreviewProvider {
    static var previews: some View {
        LeavebalancecardView(colorCard: ColorCard(theme: .bubblegum))
    }
}

struct LeavebalancecardView: View {
    let colorCard: ColorCard
    var body: some View {
        ZStack{
            HStack(spacing: 20) {
                VStack(spacing: 5) {
                    VStack {
                        Text("JAN")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.primaryColor)
                            .shadow(color: .gray, radius: 2, x: 0, y: 0)
                    )
                    Text("21")
                        .foregroundColor(.black)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                    
                }
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                )
                
                VStack(spacing: 10) {
                    Text("Not Feeling Well Today!!!")
                        .foregroundColor(.black)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                    
                    HStack(spacing: 15) {
                        Text("Sick Leave")
                            .foregroundColor(.black)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                            .frame(alignment: .leading)
                        VStack {
                            Text("Approved")
                                .foregroundColor(.white)
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .frame(alignment: .leading)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.green)
                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                        )
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(
            EdgeInsets(
                top: 20,
                leading: 20,
                bottom: 20,
                trailing: 20
            )
        )
        .background(
            RoundedRectangle(cornerRadius: 25)
                   .fill(Color.white)
                   .shadow(color: .gray, radius: 2, x: 0, y: 2)
       )
    }
}

