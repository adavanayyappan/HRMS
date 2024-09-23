//
//  MainTabbedView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable{
    case dashboard = 0
    case timesheet
    case leave
    case claim
    case myprofile
    
    var title: String{
        switch self {
        case .dashboard:
            return "Dashboard"
        case .timesheet:
            return "Time Sheet"
        case .leave:
            return "Leave"
        case .claim:
            return "Claim"
        case .myprofile:
            return "My Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .dashboard:
            return "timesheet"
        case .timesheet:
            return "timesheet"
        case .leave:
            return "leave"
        case .claim:
            return "claim"
        case .myprofile:
            return "profile"
        }
    }
}

struct MainTabbedView: View {
    
    @State var selectedTab = 0
    @StateObject private var viewModel = TimesheetViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                DashboardView()
                    .tag(0)
                
                TimesheetView()
                    .tag(1)
                    .environmentObject(viewModel)
                
                LeaveManagementView()
                    .tag(2)

                ClaimManagementView()
                    .tag(3)

                MyProfileView()
                    .tag(4)
            }
            
            HStack(spacing: 50){
                ForEach((TabbedItems.allCases), id: \.self){ item in
                    Button{
                        selectedTab = item.rawValue
                    } label: {
                        CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension MainTabbedView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        VStack(spacing: 10){
            Image(imageName)
                .resizable()
                .renderingMode(.template)
//                .foregroundColor(isActive ? .primarycolor : .gray)
                .frame(width: 20, height: 20)
            if isActive {
                Text(title)
                    .font(.system(size: 12))
//                    .foregroundColor(isActive ? .primarycolor : .gray)
            }
        }
    }
}

struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbedView()
    }
}

