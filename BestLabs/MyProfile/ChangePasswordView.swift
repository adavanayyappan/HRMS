//
//  ChangePasswordView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 08/11/24.
//

import SwiftUI

struct ChangePasswordView: View {
    @StateObject private var viewModel = ChangePasswordViewModel()
    @Environment(\.presentationMode) var presentationMode
    
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
                        Text("Change Password")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                        
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
                      
                        
                        SecureField("Confirm Password", text: $viewModel.confirmPassword)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                        
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 10)
                            .background(Color.gray)
                        
                        if let passwordError = viewModel.confirmPasswordError {
                            Text(passwordError)
                                .foregroundColor(.red)
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        }
                    
                        Button(action: {
                            viewModel.postLoginData()
                        }) {
                            Text("Confirm")
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(viewModel.isFormValid ? Color.primaryColor : Color.gray)
                                .cornerRadius(40)
                        }
                        .disabled(!viewModel.isFormValid)
                        
                        if viewModel.passwordSuccess {
                            Text("Password changed successfully")
                                .foregroundColor(.green)
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        }
                        
                        if let passwordError = viewModel.errorMessage {
                            Text(passwordError)
                                .foregroundColor(.red)
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
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
                    
                    if viewModel.isLoading {
                        LoadingView()
                            .frame(width: 150, height: 150)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            }
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .navigationBarItems(leading: Button(action: {
                // Custom back action
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left") // System back arrow
                    .foregroundColor(.white) // Custom color
            })
        }
    }
}

