//
//  ClaimManagementView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI
    //@State private var colorCards: [ColorCard] = ColorCard.sampleData
struct Box :Identifiable, Hashable {
    let id = UUID()
    let title,subtitle, total: String
    }
    
struct ClaimManagementView: View {
    @State private var colorCards: [ColorCard] = ColorCard.sampleData
    
    let boxes:[Box] = [
        Box( title: "19", subtitle:" Total",total: " 24 Leaves" ),
        Box( title: "3", subtitle:" Annual",total: " 12 Leaves" ),
        Box(title: "2", subtitle:" Sick",total: " 6 Leaves" ),
        Box( title: "5", subtitle:" Balance",total: " 5 Leaves" ),
        Box( title: "6", subtitle:" Casual",total: " 12 Leaves" )]
    var body: some View {
        VStack{
            NavigationView{
                ScrollView{
                    HStack{
                        ForEach(boxes, id: \.self) { Box in
                            BoxView(box: Box)
                            //   ForEach(boxes, id: \.self) { box in                       BoxView(box: box)
                        }
                        
                    }.padding(20)
                        .navigationBarTitle(Text("Leave Balance"))
                }
                
            }
            VStack(alignment: .leading) {
                Text("Leave Balance")
            }
        List {
            ForEach(colorCards) { colorCard in
                LeavebalancecardView(colorCard: colorCard)
                Spacer()
            }
//            .background(.gray)
//            .opacity(0.3)
//            .cornerRadius(10)
            
        }
        }
    }
}
#Preview {
    ClaimManagementView()
}
