//
//  ImageViewerView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 19/04/25.
//
import SwiftUI

struct ImageViewerView: View {
    let imageURL: URL
    @Binding var showImageViewer: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.ignoresSafeArea()

            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView().scaleEffect(1.5)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .failure:
                    Text("Image failed to load")
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }

            HStack {
                Button(action: {
                    showImageViewer = false
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }

                Text("Leave Attachment")
                    .foregroundColor(.white)
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
            }
            .padding(.top, 44)
            .padding(.horizontal)
        }

    }
}


