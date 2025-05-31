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
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    showImageViewer = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
                .padding()
            }

            Spacer()

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

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


