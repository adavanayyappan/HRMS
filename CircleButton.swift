//
//  CircleButton.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 01/03/24.
//

import SwiftUI

struct CircleButton: View {
    @State private var tapped = Bool()
    @State private var counter: Int = 0
    @State var isPresented = false
    var body: some View {
//        NavigationStack {
            VStack {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 7, y: 7)
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 50, weight: .semibold))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10
                    )
                )
                .scaleEffect(tapped ? 0.95 : 1)
                .onTapGesture {
                    tapped.toggle()
                //    LoginScreenView()
                    
              /*      isPresented =  true
                        .navigationDestination(isPresented: $isPresented, destination: LoginScreenView())
                    */
               // }
                //             .navigationDestination(isPresented: $navigated, destination: { LeaveManagementView()
                //
                //                                //.navigationBarBackButtonHidden(true)
                //                                .navigationTitle("BestLabs ")
                //                                .foregroundColor(.white)
                //                                .toolbarBackground(
                //                                    Color.black,
                //                                    for: .navigationBar)
                //                                .toolbarBackground(.visible, for: .navigationBar)
                //
                //
                //                                               })//counter += 1
                
                
                
                //LeaveManagementView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    tapped = false
                }
            }
        }
        //            Text("Tapped \(counter) times")
        //                .foregroundColor(.black)
        //                .font(.title2)
        //                .offset(y: 30)
        // }
            
    }
       
    
//    }
    
        
}
