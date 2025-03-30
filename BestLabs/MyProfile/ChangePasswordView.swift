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
            NavigationView {
                ScrollView {
                    VStack {
                        ZStack(alignment: .top) {
                            Image.dashboardBg
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()

                            VStack {
                                Spacer().frame(height: 80)

                                VStack(alignment: .leading) {
                                    Text("Change Password")
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                                        .foregroundColor(.textColor)
                                        .padding(.bottom, 1)
                                   
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
                                    
                                    SecureField("Confirm Password", text: $viewModel.password)
                                        .padding(.top, 30)
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                        .foregroundColor(.gray)
                                    
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
                                        Text("Change Password")
                                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .foregroundColor(.white)
                                            .background(Color.buttonBackgroundColor)
                                    }
                                    .cornerRadius(8)
                                    .padding(.top, 30)
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
                    
                    if viewModel.passwordSuccess {
                        Text("Password changed successfully")
                            .foregroundColor(.green)
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                }
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

