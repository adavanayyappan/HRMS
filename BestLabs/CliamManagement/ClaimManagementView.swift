//
//  ClaimManagementView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI


struct ClaimManagementView: View {
    @EnvironmentObject var viewModel: ClaimManagementViewModel
    @State private var claimItem: ClaimType? = nil
    @State private var showModal: Bool = false

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                EmptyView()
                    .foregroundColor(.red)
            } else {
                VStack {
                    ZStack(alignment: .top) {
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(viewModel.claimTypeData) { item in
                                    ClaimBoxView(item: item, selectedItem: $claimItem)
                                        .listRowInsets(EdgeInsets())
                                        .onTapGesture {
                                            claimItem = item
                                            showModal = true
                                        }
                                }
                                
                            }.padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 10,
                                    bottom: 5,
                                    trailing: 10
                                )
                            )
                        }
                        CircleButton()
                            .onTapGesture {
                                claimItem = nil
                                showModal = true
                            }
                    }
                    List {
                        ForEach(viewModel.claimRequestData) { item in
                            ClaimListView(item: item)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .sheet(isPresented: $showModal) {
            ClaimSubmitView(selectedClaimItem: $claimItem)
        }
        .onAppear {
//            viewModel.getClaimTypeData()
//            viewModel.getClaimRequestData()
        }
    }
}
