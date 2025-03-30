//
//  FloatingHeaderView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 30/06/24.
//

import SwiftUI

struct FloatingHeaderView: View {
    
    private var imagePath: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_IMAGE, defaultValue: "")
    private var serverImageUrl = "\(Constants.imageURL)"
    
    var body: some View {
        VStack() {
////            AsyncImages(url: URL(string: "\(Constants.imageURL.rawValue)\(imagePath)")!) {
//                        ProgressView()
//                }
        }
        .frame(width: 150, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
        .padding(
            EdgeInsets(
                top: 250,
                leading: 20,
                bottom: 0,
                trailing: 10
            )
        )
    }
}

struct FloatingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingHeaderView()
    }
}

