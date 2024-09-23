//
//  HeadBanner.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 11/03/24.
//

import SwiftUI

struct HeaderBanner: View {
    
    private var name: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_NAME, defaultValue: "")
    private let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)

    var body: some View {
        ZStack() {
            Image.dashboardBg
                .resizable()
                .frame(maxWidth: .infinity)
            VStack{
                Text("Welcome Back !")
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 30,
                            bottom: 25,
                            trailing: 10
                        )
                    )
                VStack(spacing: 10) {
                    Text("\(name)")
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("iOS Developer")
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 15))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(
                    EdgeInsets(
                        top: 60,
                        leading: 10,
                        bottom: 10,
                        trailing: 30
                    )
                )
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
    }
}

struct HeaderBanner_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBanner()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
