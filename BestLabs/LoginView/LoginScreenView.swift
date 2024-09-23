//
//  LoginScreenView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import SwiftUI
struct LoginScreenView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isLoading = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Image.splashscreen
                        .resizable()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                        .frame(maxHeight: 250)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Welcome")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                        Text("Login to Continue")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        TextField("E-mail or mobile number", text: $viewModel.username)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        
                        Divider()
                            .padding(.horizontal, 10)
                            .background(Color.gray)
                        
                        if let emailError = viewModel.emailError {
                            Text(emailError)
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                .foregroundColor(.red)
                        }
                        
                        SecureField("Password", text: $viewModel.password)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 10)
                            .background(Color.gray)
                        
                        if let passwordError = viewModel.passwordError {
                            Text(passwordError)
                                .foregroundColor(.red)
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        }
                    
                        Button(action: {
                            self.isLoading = true
                            viewModel.postLoginData()
                        }) {
                            Text("Login")
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(viewModel.isFormValid ? Color.primaryColor : Color.gray)
                                .cornerRadius(40)
                        }
                        .disabled(!viewModel.isFormValid)
                        
                        Button(action: {
                            
                        }) {
                            Text("Forgot Password?")
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                .foregroundColor(Color.primaryColor)
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(
                        EdgeInsets(
                            top: 50,
                            leading: 20,
                            bottom: 10,
                            trailing: 20
                        )
                    )
                    
                    if isLoading {
                        LoadingView()
                            .frame(width: 150, height: 150)
                    }
                    
                    NavigationLink(destination: MainTabbedView(), isActive: $viewModel.loginSuccess) {
                        EmptyView()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}

