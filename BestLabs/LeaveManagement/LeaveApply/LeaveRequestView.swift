//
//  LeaveRequestView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/09/24.
//

import SwiftUI

struct LeaveRequestView: View {
    @State private var appliedDate: String = "11-Oct-2024"
    @State private var numberOfDays: Int = 1
    @State private var startDate: String = "11-Oct-2024"
    @State private var endDate: String = "11-Oct-2024"
    @State private var description: String = "I am feeling Sick"
    @State private var attachmentName: String = "Attachment"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Toolbar
                Text("Leave Type")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 30)
                    .foregroundColor(.gray)

                // Worker Leave List (Placeholder)
                List {
                    ForEach(0..<10) { _ in
                        Text("Leave Entry")
                    }
                }
                .frame(maxHeight: 200)

                // Applied Date
                TextField("Applied Date", text: $appliedDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)

                // Number of Days
                Picker("Number of days", selection: $numberOfDays) {
                    ForEach(1..<31) { day in
                        Text("\(day) days").tag(day)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal, 30)

                // Start Date
                TextField("Start Date", text: $startDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)

                // End Date
                TextField("End Date", text: $endDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)

                // Description
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 80)
                    .padding(.horizontal, 30)

                // Attachment Section
                HStack {
                    Text("Attachment")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        // Action to add attachment
                    }) {
                        Text("+")
                            .frame(width: 30, height: 30)
                            .background(Color.clear)
                    }
                }
                .padding(.horizontal, 30)

                HStack {
                    Image(systemName: "doc.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text(attachmentName)
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .bold))
                }
                .padding(.horizontal, 30)

                // Apply Leave Button
                Button(action: {
                    // Action to apply for leave
                }) {
                    Text("APPLY FOR LEAVE")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 30)
                .padding(.bottom)
            }
            .navigationBarHidden(true)
            .padding()
        }
    }
}

struct LeaveRequestView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveRequestView()
    }
}

