//
//  IdentifyCameraViewControllerRepresentable.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 26/07/24.
//

import SwiftUI

struct IdentifyCameraViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> IdentifyCameraViewController {
        return IdentifyCameraViewController()
    }

    func updateUIViewController(_ uiViewController: IdentifyCameraViewController, context: Context) {}
}
