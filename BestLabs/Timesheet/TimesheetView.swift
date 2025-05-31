//
//  TimesheetView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI

struct TimesheetHeaderView: View {
    let data = ["Date", "Start Time", "End Time","Total"]
    @Binding var showDatePicker: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("TimeSheet")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                    .padding(
                        EdgeInsets(
                            top: 10,
                            leading: 10,
                            bottom: 0,
                            trailing: 10
                        )
                    )
                FilterButton()
                    .onTapGesture {
                        showDatePicker.toggle()
                }
                .frame(height: 50)
                .padding(.top, 10)
            }
            HStack {
                ForEach(data, id: \.self) { item in
                    Text(item)
                        .font(Fonts.custom(Fonts.CustomFont.lexenddeca, size: 14))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }
            }
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
            .padding(
                EdgeInsets(
                    top: 10,
                    leading: 10,
                    bottom: 0,
                    trailing: 10
                )
            )
        }
    }
}

struct TimesheetView: View {
    @EnvironmentObject var viewModel: TimesheetViewModel
    @State private var showDatePicker = false
    @State private var internalSelectedDate = Date()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let _ = viewModel.errorMessage {
                EmptyView()
            } else {
                VStack {
                    TimesheetHeaderView(showDatePicker: $showDatePicker)
                    
                    if showDatePicker {
                        DatePicker("Select a Date", selection: $internalSelectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .onChange(of: internalSelectedDate) { newDate in
                                // Format the date and pass it back to TimesheetViewModel
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM"
                                viewModel.selectedDate = formatter.string(from: newDate)
                                showDatePicker.toggle()
                        }
                        .foregroundColor(.white)
                        .padding()
                    }
                    
                    List(viewModel.data) { item in
                       TimeCardView(item: item)
                            .listRowInsets(EdgeInsets())
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .onAppear {
            viewModel.getTimeSheetData()
        }
    }
}

struct TimesheetView_Previews: PreviewProvider {
    
    static var previews: some View {
        TimesheetView()
            .environmentObject(TimesheetViewModel(data: mockTimeEntries))
            .previewLayout(.sizeThatFits)
    }
}

// Create mock TimeEntry data
let mockTimeEntries = [
    TimeEntry(dateFormat: "dd-MM-yyyy", date: "01-10-2023", day: "Monday", month: "October", startTime: "09:00 AM", endTime: "05:00 PM", totalHours: "8"),
    TimeEntry(dateFormat: "dd-MM-yyyy", date: "02-10-2024", day: "Tuesday", month: "October", startTime: "09:00 AM", endTime: "05:00 PM", totalHours: "8"),
]
