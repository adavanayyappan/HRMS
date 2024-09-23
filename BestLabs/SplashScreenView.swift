//
//  SplashScreenView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isActive {
                    LoginScreenView()
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
