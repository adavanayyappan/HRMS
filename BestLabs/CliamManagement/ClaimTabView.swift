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
