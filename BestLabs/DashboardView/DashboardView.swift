//
//  DashboardView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 11/03/24.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var showModal = false
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    ZStack(alignment: .leading) {
                        HeaderBanner()
                            .frame(height: 300)
                        FloatingHeaderView()
                    }
                    .frame(height: 300)
                    DashboardAttendanceView(timestatus: viewModel.data, showModal: $showModal)
                        .padding(
                            EdgeInsets(
                                top: 100,
                                leading: 10,
                                bottom: 0,
                                trailing: 10
                            )
                        )
                }
            }
            .foregroundColor(Color.primaryColor)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showModal) {
                
                let imagePath: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_IMAGE, defaultValue: "")
                if !imagePath.isEmpty {
                    IdentifyCameraViewControllerRepresentable()
                } else {
                    AddCameraViewControllerRepresantable()
                }
            }
        }
        .onAppear {
            viewModel.getTimeSheetStatus()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
