//
//  LeaveManagementView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//
//
//  LeaveManagementView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI

struct LeaveManagementView: View {
    @EnvironmentObject var viewModel: LeaveManagementViewModel
    @State private var leaveItem: LeaveBalance? = nil
    @State private var showModal: Bool = false
    @State private var needsRefresh = false

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let _ = viewModel.errorMessage {
                EmptyView()
                    .foregroundColor(.red)
            } else {
                VStack {
                    ZStack(alignment: .top) {
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(viewModel.leaveBalanceData) { item in
                                    LeaveBoxView(item: item, selectedItem: $leaveItem)
                                        .listRowInsets(EdgeInsets())
                                        .onTapGesture {
                                            leaveItem = item
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
                                leaveItem = nil
                                showModal = true
                        }
                    }
                    List {
                        ForEach(viewModel.leaveRequestData) { item in
                            LeaveListView(item: item)
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
            LeaveSubmitView(didUpdate: $needsRefresh, selectedLeaveItem: $leaveItem)
        }
        .onAppear {
            viewModel.getLeaveTypeData()
            viewModel.getLeaveRequestData()
        }
        .onChange(of: needsRefresh) { newValue in
            if newValue {
                viewModel.getLeaveTypeData()
                viewModel.getLeaveRequestData()
                needsRefresh = false // reset
            }
        }
    }
}
