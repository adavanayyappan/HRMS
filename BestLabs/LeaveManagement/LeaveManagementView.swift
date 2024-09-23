//
//  LeaveManagementView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//
//
//  LeaveManagementView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI

struct Box :Identifiable, Hashable {
    let id = UUID()
    let title,subtitle, total: String
}

struct LeaveManagementView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveManagementView()
    }
}

struct LeaveManagementView: View {
    @State private var colorCards: [ColorCard] = ColorCard.sampleData
    
    let boxes:[Box] = [
        Box( title: "19", subtitle:" Total",total: " 24 Leaves" ),
        Box( title: "3", subtitle:" Annual",total: " 12 Leaves" ),
        Box(title: "2", subtitle:" Sick",total: " 6 Leaves" ),
        Box( title: "5", subtitle:" Balance",total: " 5 Leaves" ),
        Box( title: "6", subtitle:" Casual",total: " 12 Leaves" )]

    
    var body: some View {
        VStack {
            HStack {
                Text("Leave Summary")
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
            
            ScrollView(.horizontal) {
                HStack{
                    ForEach(boxes, id: \.self) { Box in
                        BoxView(box: Box)
                    }
                    
                }.padding(20)
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
