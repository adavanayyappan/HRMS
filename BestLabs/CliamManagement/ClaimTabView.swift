//
//  ClaimTabView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/10/24.
//

import SwiftUI

struct ClaimTabView: View {
    @EnvironmentObject var viewModel: ClaimManagementViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("Select a Tab")) {
                Text("My Claim")
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
                ClaimManagementView()
                    .environmentObject(viewModel)
            } else {
                ClaimApprovalView()
                    .environmentObject(viewModel)
            }
            
            Spacer()
        }
    }
        
}

struct ClaimTabView_Previews: PreviewProvider {
    static var previews: some View {
        ClaimTabView()
            .environmentObject(ClaimManagementViewModel(claimTypeData: claimTypeData, claimRequestData: claimRequestData, claimApprovalData: claimApprovalData))
            .previewLayout(.sizeThatFits)
    }
}

// Add mock data to the view model
let claimTypeData = [
    ClaimType(value: 1, label: "Medical"),
    ClaimType(value: 2, label: "Travel"),
    ClaimType(value: 3, label: "Miscellaneous")
]

let claimRequestData = [
    ClaimResponse.Claim(
        claimLimitName: "Medical Expense",
        claimGroupID: 1,
        claimGroupCode: "MED01",
        claimGroupName: "Medical",
        claimID: 101,
        claimEmpID: 1,
        claimLimitPkID: 1,
        claimGroupPkID: 1,
        claimAmount: "200.00",
        claimRemarks: "Medical treatment",
        claimAttachment: "attachment1.jpg",
        claimStatus: "Pending",
        claimCreatedOn: "2025-03-01"
    ),
    ClaimResponse.Claim(
        claimLimitName: "Travel Expense",
        claimGroupID: 2,
        claimGroupCode: "TRV01",
        claimGroupName: "Travel",
        claimID: 102,
        claimEmpID: 2,
        claimLimitPkID: 2,
        claimGroupPkID: 2,
        claimAmount: "150.00",
        claimRemarks: "Business trip",
        claimAttachment: "attachment2.jpg",
        claimStatus: "Approved",
        claimCreatedOn: "2025-03-05"
    )
]

let claimApprovalData = [
    ClaimResponse.Claim(
        claimLimitName: "Travel Expense",
        claimGroupID: 2,
        claimGroupCode: "TRV02",
        claimGroupName: "Travel",
        claimID: 103,
        claimEmpID: 3,
        claimLimitPkID: 3,
        claimGroupPkID: 3,
        claimAmount: "500.00",
        claimRemarks: "Conference trip",
        claimAttachment: "attachment3.jpg",
        claimStatus: "Pending",
        claimCreatedOn: "2025-03-10"
    )
]
