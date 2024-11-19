//
//  TimesheetView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI

struct TimesheetHeaderView: View {
    let data = ["Date", "Start Time", "End Time","Total"]
    var body: some View {
        VStack(alignment: .leading) {
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
            HStack {
                ForEach(data, id: \.self) { item in
                    Text(item)
                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
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
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let _ = viewModel.errorMessage {
                EmptyView()
            } else {
                VStack {
                    TimesheetHeaderView()
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
    }
}
