//
//  AddCameraViewControllerRepresantable.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 26/07/24.
//

import SwiftUI

struct AddCameraViewControllerRepresantable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AddCameraViewController {
        return AddCameraViewController()
    }

    func updateUIViewController(_ uiViewController: AddCameraViewController, context: Context) {}
}

