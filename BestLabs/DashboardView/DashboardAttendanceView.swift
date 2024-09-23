//
//  DashboardAttendanceView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 30/06/24.
//

import SwiftUI

struct DashboardAttendanceView: View {
    
    private var  timestatus: PunchStatusResponse?
    @Binding var showModal: Bool
    
    init(timestatus: PunchStatusResponse?, showModal: Binding<Bool>) {
        self.timestatus = timestatus
        self._showModal = showModal
    }
    
    var body: some View {
        VStack() {
            Text("Attendance")
                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 10) {
                Text("\(Date(), formatter: DateFormatter.currentTime)")
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                    .frame(maxWidth: .infinity, alignment: .top)
                    .foregroundColor(Color.primaryColor)
                    .padding(
                        EdgeInsets(
                            top: 5,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        )
                    )
                Text("\(Date(), formatter: DateFormatter.dayMonthYear)")
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                    .frame(maxWidth: .infinity, alignment: .top)
                    .foregroundColor(Color.primaryColor)
                
                Image.facescan
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .top)
                    .onTapGesture {
                        showModal = true
                    }
            }
            .frame(width: 300, height: 300)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
            .padding(
                EdgeInsets(
                    top: 25,
                    leading: 10,
                    bottom: 0,
                    trailing: 10
                )
            )
            VStack {
                HStack {
                    VStack{
                        Image.clock
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(timestatus?.satrtTime ?? "--:--")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                            .frame(maxWidth: .infinity-75
                            )
                    }
                    
                    VStack{
                        Image.checkout
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(timestatus?.endTime ?? "--:--")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                            .frame(maxWidth: .infinity-75
                            )
                    }
                    
                    VStack{
                        Image.workinghrs
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(timestatus?.totalHrs ?? "--:--")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                            .frame(maxWidth: .infinity-75
                            )
                    }
                }
                .frame(height: 125)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                )
            }
            .padding(
                EdgeInsets(
                    top: 25,
                    leading: 10,
                    bottom: 25,
                    trailing: 10
                )
            )
        }
    }
}

