//
//  ForgotPasswordView.swift
//  BestLabs
//
//  Created by Adavan on 15/03/25.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
                            Text("Reset Password")
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                                .foregroundColor(.textColor)
                                .padding(.bottom, 1)
                           
                            TextField("E-mail or mobile number", text: $viewModel.empEmailId)
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
                            
                            TextField("OTP", text: $viewModel.otp)
                                .padding(.top, 30)
                                .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                .foregroundColor(.gray)
                            
                            Divider()
                                .padding(.horizontal, 10)
                                .background(Color.gray)
                            
                            if let otpError = viewModel.otpError {
                                Text(otpError)
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
                                viewModel.postResetPasswordData()
                            }) {
                                Text("Submit")
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.buttonBackgroundColor)
                            }
                            .onChange(of: viewModel.resetPasswordSuccess) { success in
                                if success {
                                    dismiss()
                                    dismiss()
                                }
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
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .navigationBarItems(leading: Button(action: {
            // Custom back action
            self.dismiss()
        }) {
            Image(systemName: "chevron.left") // System back arrow
                .foregroundColor(.white) // Custom color
        })
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}



