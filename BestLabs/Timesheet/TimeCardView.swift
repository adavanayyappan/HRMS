//
//  CardView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 21/02/24.
//

import SwiftUI

struct TimeCardView: View {
    
    var item: TimeEntry
    var convertedDate : String = ""
    var convertedYear : String = ""
    
    init(item: TimeEntry) {
        self.item = item
        guard let date = Dater.shared.date(from: "01-10-2023", format: "dd-MM-yyyy") else {
            return
        }
        self.convertedDate = Dater.shared.string(from: date, format: "dd") ?? ""
        self.convertedYear = Dater.shared.string(from: date, format: "EEE, MMM \nyyyy") ?? ""
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center){
                Text(convertedDate)
                .multilineTextAlignment(.center)
                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.timeTextColor)
                
                Text(convertedYear)
                .multilineTextAlignment(.center)
                .font(Fonts.custom(Fonts.CustomFont.lexenddeca, size: 10))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.timeTextColor)
            }
            Text(item.startTime)
                .font(Fonts.custom(Fonts.CustomFont.lexenddeca, size: 14))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color.timeTextColor)
            
            Text(item.endTime ?? "")
                .font(Fonts.custom(Fonts.CustomFont.lexenddeca, size: 14))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color.timeTextColor)
            
            VStack{
                Text(item.totalHours ?? "")
                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 20))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.timeTextColor)
                
                Text("Working Hours")
                .multilineTextAlignment(.center)
                .font(Fonts.custom(Fonts.CustomFont.lexenddeca, size: 10))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.timeTextColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 100)
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


