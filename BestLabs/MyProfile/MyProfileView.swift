//
//  MyProfileView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI

import SwiftUI

struct MyProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    private var name: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_NAME, defaultValue: "")
    
    private var imagePath: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_IMAGE, defaultValue: "")
    private var serverImageUrl = "\(Constants.imageURL)"
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                VStack {
                    VStack() {
                        AsyncImages(url: URL(string: "\(Constants.imageURL.rawValue)\(imagePath)")!) {
                                    ProgressView()
                            }
                    }
                    .frame(width: 150, height: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
//                            .fill(Color.primarycolor)
                            .shadow(color: .gray, radius: 1, x: 0, y: 2)
                    )
                    
                    Text(name) // Replace with the user's name
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                        .padding(.top, 8)
                }
                
                // List items
                List {
                    NavigationLink(destination: EditProfileView()) {
                        Text("My Profile")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                    }
                    
                    NavigationLink(destination: TermsAndConditionsView()) {
                        Text("Terms and Conditions")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                    }
                    
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("Privacy Policy")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                    }
                    
                    Button(action: {
                        // Handle logout
                    }) {
                        Text("Logout")
                            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                            .foregroundColor(.red)
                    }
                }
                .listStyle(GroupedListStyle())
            }
        }
    }
}

struct EditProfileView: View {
    var body: some View {
        Text("My Profile")
            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
            .navigationBarTitle("My Profile", displayMode: .inline)
    }
}

struct TermsAndConditionsView: View {
    var body: some View {
        Text("Terms and Conditions")
            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
            .navigationBarTitle("Terms and Conditions", displayMode: .inline)
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        Text("Privacy Policy")
            .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
            .navigationBarTitle("Privacy Policy", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}

