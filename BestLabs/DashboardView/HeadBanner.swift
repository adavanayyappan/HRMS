//
//  HeadBanner.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 11/03/24.
//

import SwiftUI

struct HeaderBanner: View {
    @State var isPresented = false
/*
    @AppStorage("rValue") var rValue = DefaultSettings.rValue
    @AppStorage("gValue") var gValue = DefaultSettings.gValue
    @AppStorage("bValue") var bValue = DefaultSettings.bValue
    */
    var body: some View {
       // ZStack(alignment: .bottom) {
        ZStack() {
            //Rectangle()
               // .background(.blue)
            //   .foregroundColor(Color(red: rValue, green: gValue, blue: bValue, opacity: 1.0))
              //
              //  .frame(height: 250)
               // .background(.blue)
            VStack{
                Text("Welcome Back !")
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(
                        EdgeInsets(
                            top: 50,
                            leading: 10,
                            bottom: 25,
                            trailing: 10
                        )
                    )
                Button (
                    action: { self.isPresented = true },
                    label: {
                        Label("", systemImage: "pencil")
                })
                .sheet(isPresented: $isPresented, content: {
                  //  SettingsView()
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                HStack(alignment: .top) {
                    Image("face")
                    //   .frame(width: 100, height: 100)
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                    VStack{
                        Text("Suresh Swaminathan")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("iOS Developer")
                            .frame(maxWidth: .infinity, alignment: .leading)
                           // .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding(
                        EdgeInsets(
                            top: 50,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
                }
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10
                    )
                )
            }
           // .background(.blue)
        }
        .edgesIgnoringSafeArea(.top)
        .cornerRadius(20)
        
    }
    
}
