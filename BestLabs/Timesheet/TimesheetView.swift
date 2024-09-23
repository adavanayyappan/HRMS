//
//  TimesheetView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI

struct TimesheetView: View {
    @State private var colorCards: [ColorCard] = ColorCard.sampleData
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                Image("suresh")
               
                    .resizable()
                //.placeholder(Image("profilePic"))
                //.indicator(.activity)
                // .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .frame(width: 100)
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                    .clipShape(Circle())
                Text("Suresh Swaminathan")
                Text("Sr.iOS Developer")
            }
            
        HStack {
            
            
            Text("Date")
                .foregroundColor(.black)
                .font(.headline)
                .padding(
                    EdgeInsets(
                        top: 25,
                        leading: 10,
                        bottom: 25,
                        trailing: 5
                    )
                )
            
            
            Text("Start Time")
                .foregroundColor(.black)
                .font(.headline)
                .padding(
                    EdgeInsets(
                        top: 25,
                        leading: 5,
                        bottom: 25,
                        trailing: 5
                    )
                )
            
            Text("End Time")
                .foregroundColor(.black)
                .font(.headline)
                .padding(
                    EdgeInsets(
                        top: 25,
                        leading: 5,
                        bottom: 25,
                        trailing: 5
                    )
                )
            
            Text("Total")
                .foregroundColor(.black)
                .font(.headline)
                .padding(
                    EdgeInsets(
                        top: 25,
                        leading: 5,
                        bottom: 25,
                        trailing: 10
                    )
                )
            
            
            
        }
        .background(
               RoundedRectangle(cornerRadius: 25)
                   .fill(Color.white)
                   .shadow(color: .gray, radius: 2, x: 0, y: 2)
       )
        //.background(.green)
        //.opacity(0.3)
        
            

        List {
            ForEach(colorCards) { colorCard in
                //     NavigationLink(destination: colorCard.theme.mainColor) {
                CardView(colorCard: colorCard)
                //   }
                  //.listRowSeparator(.hidden)
                
//                             //   .listRowBackground(
//                                    RoundedRectangle(cornerRadius: 25)
//                                        .background(.green))
//                
                           
                //                )
         //  Spacer()
            } //
  //.background(.gray)
        //   .opacity(0.3)
      //.cornerRadius(10)
          
            
            //            .onDelete { idx in
            //                colorCards.remove(atOffsets: idx)
            //            }
        }
     
        //.background(.white)
        // .background(.white.opacity(0.2))
        // .opacity(0.3)
        //.listStyle(.plain)
        //        .navigationTitle("Color Cards")
        //        .toolbar {
        //            Button {
        //                colorCards.append(ColorCard(theme: Theme.allCases.randomElement()!))
        //            } label: {
        //                Image(systemName: "plus")
        //            }
        //        }
    }
    
}
}
#Preview {
    TimesheetView()
}
