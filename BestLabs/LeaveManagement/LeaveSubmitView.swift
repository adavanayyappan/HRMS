//
//  LeaveSubmitView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 27/07/24.
//

import SwiftUI

struct LeaveSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveSubmitView()
    }
}

struct LeaveSubmitView: View {
    @State private var colorCards: [ColorCard] = ColorCard.sampleData
    @Environment(\.presentationMode) var presentationMode
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    let boxes:[Box] = [
        Box( title: "19", subtitle:" Total",total: " 24 Leaves" ),
        Box( title: "3", subtitle:" Annual",total: " 12 Leaves" ),
        Box(title: "2", subtitle:" Sick",total: " 6 Leaves" ),
        Box( title: "5", subtitle:" Balance",total: " 5 Leaves" ),
        Box( title: "6", subtitle:" Casual",total: " 12 Leaves" )]

    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 0
                    )
                )
                
                Text("Apply Leave")
//                    .foregroundColor(.primarycolor)
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                    .padding(
                        EdgeInsets(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack{
                    ForEach(boxes, id: \.self) { Box in
                        BoxView(box: Box)
                    }
                    
                }.padding(20)
            }
            
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10){
                        Text("Applied Date")
                            .foregroundColor(.gray)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        
                        Text("\(Date(), formatter: DateFormatter.dayMonthYear)")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                            .foregroundColor(Color.primaryColor)
                        
                        Divider()
                            .padding(.horizontal, 10)
                            .background(Color.gray)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("Start Date")
                            .foregroundColor(.gray)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        
                        DatePicker("Select Start Date", selection: $startDate, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(GraphicalDatePickerStyle())
                        
                        Divider()
                            .padding(.horizontal, 10)
                            .background(Color.gray)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("End Date")
                            .foregroundColor(.gray)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        
                        DatePicker("Select End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(GraphicalDatePickerStyle())
                        
                        Divider()
                            .padding(.horizontal, 10)
                            .background(Color.gray)
                        
                    }
                }
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 20,
                        bottom: 10,
                        trailing: 20
                    )
                )
            }
        }
    }
}
