//
//  LeavebalancecardView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import SwiftUI

struct LeavebalancecardView: View {
    let colorCard: ColorCard

    var body: some View {
        
        HStack {

            VStack {
                Text("JAN")
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text("21")
                    .foregroundColor(.black)
                    .font(.headline)
              
                    }
                .padding(
                    EdgeInsets(
                        top: 25,
                        leading: 5,
                        bottom: 25,
                        trailing: 5
                    )
                )
            
            VStack
            {
                Text("Not Feelin Well Today!!!")
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding(
                        EdgeInsets(
                            top: 10,
                            leading: 5,
                            bottom: 10,
                            trailing: 5
                        )
                    )
                HStack{
                    Text("Sick Leave")
                        .foregroundColor(.black)
                        .font(.headline)
                    Text("Approved")
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 5,
                        bottom: 10,
                        trailing: 25
                    )
                )
                
                
                
                
            }
            
      
            
        }
        .background(
               RoundedRectangle(cornerRadius: 25)
                   .fill(Color.white)
                   .shadow(color: .gray, radius: 2, x: 0, y: 2)
       )
    }
        
    
}

