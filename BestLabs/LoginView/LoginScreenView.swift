//
//  LoginScreenView.swift
//  BestLabs
//
//
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State var forgotPassword: Bool = false
    @State var isLoggedIn = false
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        ZStack(alignment: .top) {
                            Image.splashscreen
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()

                            VStack {
                                Spacer().frame(height: 80)

                                VStack(alignment: .leading) {
                                    Text("Welcome")
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                                        .foregroundColor(.textColor)
                                        .padding(.bottom, 1)
                                    
                                    Text("Login to Continue")
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 13))
                                        .foregroundColor(.gray)
                                        
                                    
                                    TextField("E-mail or mobile number", text: $viewModel.username)
                                        .padding(.top, 30)
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                        .foregroundColor(.gray)
                                    
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
                                        .padding(.top, 30)
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                        .foregroundColor(.gray)
                                    
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
                                        viewModel.postLoginData()
                                    }) {
                                        Text("Login")
                                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .foregroundColor(.white)
                                            .background(viewModel.isFormValid ? Color.buttonBackgroundColor : Color.gray)
                                    }
                                    .cornerRadius(8)
                                    .padding(.top, 30)
                                    .disabled(!viewModel.isFormValid)
                                    
                                    Button(action: {
                                        forgotPassword.toggle()
                                    }) {
                                        Text("Forgot Password?")
                                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 13))
                                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                            .foregroundColor(.textColor)
                                    }
                                    .padding(.top, 20)
                                    
                                    if let passwordError = viewModel.errorMessage {
                                        Text(passwordError)
                                            .foregroundColor(.red)
                                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                    }
                                }
                                .padding(30)
                            }
                            .background(Color.white)
                            .cornerRadius(30)
                            .padding(.top, 180)
                            .padding(.bottom, -30)
                        }
                    }
                    
                    if viewModel.isLoading {
                        LoadingView()
                            .frame(width: 150, height: 150)
                    }
                    
                    NavigationLink(destination: MainTabbedView(loginViewModel: viewModel), isActive: $viewModel.loginSuccess) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: ForgotPasswordView(), isActive: $forgotPassword) {
                        EmptyView()
                    }
                }
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}

