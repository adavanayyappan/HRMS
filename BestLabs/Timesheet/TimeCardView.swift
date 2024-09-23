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
        guard let date = Dater.shared.date(from: item.dateFormat, format: "dd-MM-yyyy") else {
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
                .foregroundColor(.black)
                
                Text(convertedYear)
                .multilineTextAlignment(.center)
                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.black)
            }
            Text(item.startTime)
            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.black)
            
            Text(item.endTime ?? "")
            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.black)
            
            VStack{
                Text(item.totalHours ?? "")
                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.black)
                
                Text("Working Hours")
                .multilineTextAlignment(.center)
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


