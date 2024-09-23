//
//  ImageLoader.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 24/07/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func load(url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct AsyncImages<Placeholder: View>: View {
    @StateObject private var loader = ImageLoader()
    private let url: URL
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image

    init(url: URL,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        self.url = url
        self.placeholder = placeholder()
        self.image = image
    }

    var body: some View {
        content
            .onAppear{
                loader.load(url: url)
            }
            .onDisappear(perform: loader.cancel)
    }

    private var content: some View {
        Group {
            if let image = loader.image {
                self.image(image)
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
            }
        }
    }
}


