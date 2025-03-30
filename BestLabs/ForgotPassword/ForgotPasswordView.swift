//
//  ForgotPasswordView.swift
//  BestLabs
//
//  Created by Adavan on 15/03/25.
//

import SwiftUI

struct ForgotPasswordView: View {
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
                            Text("Forgot Password")
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
                            
                        
                            Button(action: {
                                viewModel.postForgotPasswordData()
                            }) {
                                Text("Submit")
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
            
            NavigationLink(destination: ResetPasswordView(), isActive: $viewModel.forgotPasswordSuccess) {
                EmptyView()
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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}



