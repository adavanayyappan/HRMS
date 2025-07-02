//
//  SplashScreenView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isActive {
                    if locationManager.authorizationStatus == .authorizedWhenInUse {
                            LoginScreenView()
                        } else if locationManager.authorizationStatus == .denied {
                            ZStack {
                                
                                Image.splashscreen
                                    .resizable()
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                                    .clipped()
                                    .edgesIgnoringSafeArea(.all)
                                
                                Text("Location access denied. Please grant permssion in settings to continue")
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                                    .foregroundColor(.white)
                                    .padding(.top, 240)
                                    .padding(.leading, 10)
                                    .padding(.trailing, 10)
                            }
                        } else {
                            Image.splashscreen
                                .resizable()
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                                .clipped()
                                .edgesIgnoringSafeArea(.all)
                        }
                    
                } else {
                    Image.splashscreen
                        .resizable()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
