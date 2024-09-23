//
//  BoxView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 24/02/24.
//

import SwiftUI

struct BoxView: View {
    let box: Box
    var body: some View {
        
        VStack {
            VStack(alignment: .center) {
                Text(box.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(box.subtitle)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(box.total)
                    .font(.caption)
                    .fontWeight(.bold)
            }.fixedSize(horizontal: true, vertical: false)
        }
        .background(
               RoundedRectangle(cornerRadius: 5)
                   .fill(Color.white)
                   .shadow(color: .gray, radius: 2, x: 0, y: 2)
       )
    }
}
    
