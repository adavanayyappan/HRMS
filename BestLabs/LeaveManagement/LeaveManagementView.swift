//
//  LeaveManagementView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI


//struct Box :Identifiable, Hashable {
//    let id = UUID()
//    let title,subtitle, total: String
//    }
//    

//struct Box: Identifiable {
//    let id = UUID()
//    let title: String
//    let subtitle: String
//    let total: String
//}
struct LeaveManagementView: View {
    var body: some View {
        Text("LeaveManagementView")
    }
    
//    
//    let boxes:[Box] = [
//        Box( title: "19", subtitle:" Total",total: " 24 Leaves" ),
//        Box( title: "3", subtitle:" Annual",total: " 12 Leaves" ),
//        Box(title: "2", subtitle:" Sick",total: " 6 Leaves" ),
//        Box( title: "5", subtitle:" Balance",total: " 5 Leaves" ),
//        Box( title: "6", subtitle:" Casual",total: " 12 Leaves" )]
//    var body: some View {
//        
//        NavigationView{
//            ScrollView{
//                HStack{
//                    
//                    ForEach(boxes.items) { item in
//                        BoxView(box: Box)
//                    }
////                    ForEach(boxes, id: \.self) { Box in
////                       BoxView(box: Box)
////                 //   ForEach(boxes, id: \.self) { box in                       BoxView(box: box)
////                    }
//                    
//                }.padding(20)
//                    .navigationBarTitle(Text("Claim Management"))
//            }
//            
//        }
//        
//    }
}

#Preview {
    LeaveManagementView()
}

