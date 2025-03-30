//
//  LeaveTabView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 22/10/24.
//

import SwiftUI

struct LeaveTabView: View {
    @EnvironmentObject var viewModel: LeaveManagementViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("Select a Tab")) {
                Text("My Leaves")
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                    .tag(0)
                Text("Approvals")
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 22))
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Display content based on the selected tab
            if selectedTab == 0 {
                LeaveManagementView()
                    .environmentObject(viewModel)
            } else {
                LeaveApproveView()
                    .environmentObject(viewModel)
            }
            
            Spacer()
        }
    }
        
}

struct LeaveTabViewView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveTabView()
            .environmentObject(LeaveManagementViewModel(leaveBalanceData: mockLeaveBalanceData, leaveRequestData: mockLeaveRequestsData, leaveApprovalData: mockLeaveRequestsData))
            .previewLayout(.sizeThatFits)
    }
    
}


// MARK: - Mock Data for LeaveBalance
let mockLeaveBalanceData: [LeaveBalance] = [
    LeaveBalance(label: "Sick Leave", value: 12, balanceLeave: 6),
    LeaveBalance(label: "Casual Leave", value: 10, balanceLeave: 4),
    LeaveBalance(label: "Vacation Leave", value: 20, balanceLeave: 15)
]

// MARK: - Mock Data for LeaveRequestListResponse.Leave
let mockLeaveRequestsData: [LeaveRequestListResponse.Leave] = [
    LeaveRequestListResponse.Leave(
        leaveGroupCode: "SL001",
        LeaveGroupName: "Sick Leave",
        leaveID: 1,
        leaveClientID: 101,
        leaveEmpID: 1001,
        leaveFrom: "2025-03-01",
        leaveTo: "2025-03-03",
        leaveNoOfDays: 3,
        leaveRemarks: "Not feeling well",
        leaveAttachment: nil,
        leaveStatus: "Pending",
        leaveCreatedOn: "2025-02-28"
    ),
    LeaveRequestListResponse.Leave(
        leaveGroupCode: "CL001",
        LeaveGroupName: "Casual Leave",
        leaveID: 2,
        leaveClientID: 102,
        leaveEmpID: 1002,
        leaveFrom: "2025-03-10",
        leaveTo: "2025-03-12",
        leaveNoOfDays: 2,
        leaveRemarks: "Personal work",
        leaveAttachment: "Leave_Certificate.pdf",
        leaveStatus: "Approved",
        leaveCreatedOn: "2025-02-25"
    )
]
