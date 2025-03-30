//
//  CircleButton.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 01/03/24.
//

import SwiftUI

struct CircleButton: View {
    var body: some View {
            VStack {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 7, y: 7)
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 50, weight: .semibold))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10
                    )
                )
        }
    }
}

struct FilterButton: View {
    var body: some View {
            VStack {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 7, y: 7)
                    Image("ic_filter")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10
                    )
                )
        }
    }
}

