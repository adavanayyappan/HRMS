//
//  LoadingView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 29/06/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.headline)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2.0, anchor: .center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

