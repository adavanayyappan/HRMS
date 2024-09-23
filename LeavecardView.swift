//
//  LeavecardView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 24/02/24.
//

import SwiftUI

struct LeavecardView: View {
    let colorCard: ColorCard

    var body: some View {
        
        HStack {
//            Text(colorCard.theme.name)
//                .foregroundColor(colorCard.theme.accentColor)
//                .font(.headline)
//                .padding(
//                    EdgeInsets(
//                        top: 25,
//                        leading: 5,
//                        bottom: 25,
//                        trailing: 5
//                    )
//                )
    
            Group {
                VStack {
                    Text("21")
                        .foregroundColor(.black)
                        .font(.headline)
                    Text("Sun, Jan 2024")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        }
                    .padding(
                        EdgeInsets(
                            top: 25,
                            leading: 5,
                            bottom: 25,
                            trailing: 5
                        )
                )
            }
            
            
            Text("09.00 AM")
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
            
           
            
            
            Text("05.00 AM")
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
          
            
            VStack {
                Text("08.00")
                    .foregroundColor(.black)
                    .font(.headline)
                Text("Working HRS")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    }
            .padding(
                EdgeInsets(
                    top: 25,
                    leading: 5,
                    bottom: 25,
                    trailing: 5
                )
            )
            
        }
   
// .background(.white)
// .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))//, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
// .shadow(radius: 8)
//     
 .background(
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
)
        
    }
}
#Preview {
    LoginView()
}


