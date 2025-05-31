//
//  LeaveApproveView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/10/24.
//

import SwiftUI

struct LeaveApproveView: View {
    @EnvironmentObject var viewModel: LeaveManagementViewModel
    @State private var showBottomSheet = false
    @State private var showAlert = false
    @State private var remarks = ""

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if viewModel.errorMessage != nil {
                EmptyView()
                    .foregroundColor(.red)
            } else {
                VStack {
                    List {
                        ForEach(viewModel.leaveApprovalData) { item in
                            LeaveListView(item: item)
                                .listRowInsets(EdgeInsets())
                                .onTapGesture {
                                    viewModel.leaveId = "\(item.leaveID ?? 0)"
                                    showBottomSheet.toggle()
                                }
                        }
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .alert(isPresented: $showBottomSheet) {
            Alert(
                title: Text("Approve Leave"),
                message: Text(""),
                primaryButton: .default(Text("Approve"), action: {
                    // Handle the OK action
                    showBottomSheet.toggle()
                    viewModel.remarks = remarks
                    viewModel.actionType = "Approve"
                    viewModel.postApproveLeave()
                }),
                secondaryButton: .default(Text("Reject"), action: {
                    // Handle the OK action
                    showBottomSheet.toggle()
                    showAlert.toggle()
                })
            )
        }
        .overlay(
            // Custom Alert
            Group {
                if showAlert {
                    Color.black.opacity(0.4) // Background dim effect
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            // Dismiss the alert when tapping outside
                            showAlert.toggle()
                        }
                    
                    VStack {
                        Text("Enter Remark")
                            .font(.headline)
                            .padding()

                        TextField("Please enter your remark below:", text: $remarks)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250)

                        HStack {
                            Button("Cancel") {
                                // Dismiss the alert without action
                                showAlert.toggle()
                            }
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)

                            Button("Submit") {
                                viewModel.remarks = remarks
                                viewModel.actionType = "Reject"
                                viewModel.postApproveLeave()
                                showAlert.toggle() // Dismiss the alert
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .padding()

                    }
                    .frame(width: 300, height: 250)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .transition(.scale) // Smooth scale transition
                }
            }
            .animation(.easeInOut, value: showAlert)
        )
        .onAppear {
            viewModel.getLeaveApprovalData()
        }
    }
}

