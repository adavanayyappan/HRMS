//
//  LoginScreenView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject var vm = ViewModel()
    @State var navigated = false
    var body: some View {
        ZStack {
            VStack {
                Image.splashscreen
                    .resizable()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(maxHeight: 200)
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    Text("Welcome")
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                    Text("Login to Continue")
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    TextField("E-mail or id", text: $vm.username)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        .textInputAutocapitalization(.never)
                        .baselineOffset(-2)
                    
                    Divider()
                        .padding(.horizontal, 30)
                        .background(Color.gray)
                   
                    SecureField("Password", text: $vm.password)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        .textInputAutocapitalization(.never)
                        .privacySensitive()
                    
                    Divider()
                        .frame(height: 1)
                        .padding(.horizontal, 30)
                        .background(Color.gray)
                    
                    Button(action: { self.navigated.toggle()}) {
                        Text("Login")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.primaryColor)
                            .cornerRadius(40)
                    }
                    HStack {
                        Button("Forgot password?", action: vm.logPressed)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                            .tint(.black)
                        Spacer()
                    }
                    Spacer()
                }
                .alert("Access denied", isPresented: $vm.invalid) {
                    Button("Dismiss", action: vm.logPressed)
                }
                .frame(width: 300)
                .padding()
            }
        }
        .navigationDestination(isPresented: $navigated, destination: { MainTabbedView()
                .navigationBarBackButtonHidden(true)
                .navigationTitle("BestLabs ")
                .foregroundColor(.white)
                .toolbarBackground(
                    Color.black,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            
            
        })
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}

