//
//  LeaveapplyView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 02/03/24.
//

import SwiftUI



//struct Box :Identifiable, Hashable {
//    let id = UUID()
//    let title,subtitle, total: String
//    }
/*
struct LeaveapplyView: View {
    @State var selection1: String? = nil
    @State private var description = "Food Allowance"
    @State private var Currentdate = nil
    @State private var colorCards: [ColorCard] = ColorCard.sampleData
    var components = DateComponents()
   Currentdate = Date.now //Calendar.current.date(from: components) ?? .now
    //    let boxes:[Box] = [
    //        Box( title: "19", subtitle:" Total",total: " 24 Leaves" ),
    //        Box( title: "3", subtitle:" Annual",total: " 12 Leaves" ),
    //        Box(title: "2", subtitle:" Sick",total: " 6 Leaves" ),
    //        Box( title: "5", subtitle:" Balance",total: " 5 Leaves" ),
    //        Box( title: "6", subtitle:" Casual",total: " 12 Leaves" )]
    
    var body: some View {
        ZStack{
            VStack{
                Text("Leave Type")
                    .foregroundColor(.black)
                    .font(.title2
                        .bold())
                
                //.multilineTextAlignment(.leading)
                    .padding(
                        EdgeInsets(
                            top: 10,
                            leading: 5,
                            bottom: 10,
                            trailing: 10
                        )
                    )
                
                Text("Apply Date")
               
                TextField("date.now()", text: $Currentdate.formatted(.dateTime.day().month().year()) 
                    .textSelection(.enabled),
                //                let currentdate = Date.now, format: .dateTime.day().month().year()
                Text(Date.now, format: .dateTime.day().month().year())
                //  TextField("date", text: $date1)
                //                    .textInputAutocapitalization(.never)
                //                    .baselineOffset(-2)
                    .padding(
                        EdgeInsets(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
                
                DropdownPickerView(
                    selection: $selection1,
                    options: [
                        "Food Allowance",
                        "Travel Allowance",
                        "Laptop",
                        "Accommodation"
                    ]
                )
                
                
                Text("Description")
                TextField("Food Allowance", text: $description)
                Button(action: {}) {
                    Text("APPLY FOR ALLOWANCE")
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(.black)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding(
                            EdgeInsets(
                                top: 10,
                                leading: 10,
                                bottom: 10,
                                trailing: 10
                            )
                        )
                    // .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                    //.cornerRadius(40)
                }
                
                /*    ScrollView(.horizontal) {
                 HStack{
                 ForEach(boxes, id: \.self) { Box in
                 BoxView(box: Box)
                 //   .frame(width: 200, height: 200)
                 //   ForEach(boxes, id: \.self) { box in                       BoxView(box: box)
                 }
                 
                 }.padding(20)
                 //                    .navigationBarTitle(Text("Leave Balance"))
                 }
                 }*/
            }
        }
    }
}

#Preview {
    LeaveapplyView()
}


*/
