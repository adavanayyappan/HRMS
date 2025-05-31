//
//  LeaveSubmitView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 27/07/24.
//

import SwiftUI
import PhotosUI

struct LeaveSubmitView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: LeaveManagementViewModel
    @Binding var didUpdate: Bool
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var description: String = ""
    @State private var attachmentName: String = ""
    @Binding var selectedLeaveItem: LeaveBalance?
    @State private var showStartDatePicker = false
    @State private var showEndDatePicker = false
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @StateObject private var submitViewModel = LeaveSubmitViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                .padding(
                    EdgeInsets(
                        top: 20,
                        leading: 10,
                        bottom: 10,
                        trailing: 0
                    )
                )
                
                Text("Apply Leave")
                    .foregroundColor(Color.buttonBackgroundColor)
                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 24))
                    .padding(
                        EdgeInsets(
                            top: 20,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            ZStack {
                
                VStack {
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(viewModel.leaveBalanceData) { item in
                                LeaveBoxView(item: item, selectedItem: $selectedLeaveItem)
                                    .listRowInsets(EdgeInsets())
                                    .onTapGesture {
                                        selectedLeaveItem = item
                                    }
                            }
                        }.padding(
                            EdgeInsets(
                                top: 10,
                                leading: 10,
                                bottom: 5,
                                trailing: 10
                            )
                        )
                    }
                    
                
                    ScrollView(.vertical) {
                        VStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 10){
                                Text("Applied Date")
                                    .foregroundColor(.gray)
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                
                                Text("\(Date(), formatter: DateFormatter.dateMonthYear)")
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                                    .foregroundColor(Color.buttonBackgroundColor)
                                
                                Divider()
                                    .padding(.horizontal, 10)
                                    .background(Color.gray)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text("Start Date")
                                    .foregroundColor(.gray)
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                
                                HStack {
                                    Text("\(startDate, formatter: DateFormatter.dateMonthYear)")
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                                        .foregroundColor(Color.buttonBackgroundColor)
                                    Spacer()
                                    
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .onTapGesture {
                                            // Show the date picker when text is tapped
                                            showStartDatePicker.toggle()
                                        }
                                }
                    
                                // DatePicker dialog
                                if showStartDatePicker {
                                    DatePicker("Select Date", selection: $startDate, displayedComponents: .date)
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .onChange(of: startDate) { newValue in
                                            // Update the selected date when the user picks a new date
                                            showStartDatePicker = false // Hide the date picker after selection
                                        }
                                }
                                
                                Divider()
                                    .padding(.horizontal, 10)
                                    .background(Color.gray)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text("End Date")
                                    .foregroundColor(.gray)
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                
                                HStack {
                                    Text("\(endDate, formatter: DateFormatter.dateMonthYear)")
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 12))
                                        .foregroundColor(Color.buttonBackgroundColor)
                  
                                    Spacer()
                                    
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .onTapGesture {
                                            // Show the date picker when text is tapped
                                            showEndDatePicker.toggle()
                                        }
                                }
                                
                                // DatePicker dialog
                                if showEndDatePicker {
                                    DatePicker("Select End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .padding()
                                        .onChange(of: endDate) { newValue in
                                            // Update the selected date when the user picks a new date
                                            showEndDatePicker = false // Hide the date picker after selection
                                        }
                                }
                                
                                Divider()
                                    .padding(.horizontal, 10)
                                    .background(Color.gray)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 20) {
                                TextField("Description", text: $submitViewModel.description)
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                
                                Divider()
                                    .padding(.horizontal, 10)
                                    .background(Color.gray)
                                
                                if let descriptionError = submitViewModel.descriptionError {
                                    Text(descriptionError)
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                        .foregroundColor(.red)
                                }
                            }
                            
                            // Attachment Section
                            HStack {
                                Text("Attachment")
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Button(action: {
                                    isImagePickerPresented = true
                                }) {
                                    Text("+")
                                        .frame(width: 30, height: 30)
                                        .background(Color.clear)
                                }
                                .sheet(isPresented: $isImagePickerPresented) {
                                    ImagePicker(selectedImage: $selectedImage, imageName: $attachmentName)
                                }
                            }
                            
                            if selectedImage != nil {
                                HStack {
                                    Image(systemName: "doc.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text(attachmentName)
                                        .foregroundColor(.gray)
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                    Spacer()
                                }

                            }
                            // Apply Leave Button
                            Button(action: {
                                submitViewModel.startDate = DateFormatter.dateMonthYear.string(from: startDate)
                                submitViewModel.endDate = DateFormatter.dateMonthYear.string(from: endDate)
                                submitViewModel.detectedImage = selectedImage
                                if let leaveId = selectedLeaveItem?.value {
                                    submitViewModel.leaveId = "\(leaveId)"
                                }
                                submitViewModel.postApplyLeave()
                            }) {
                                Text("APPLY")
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.buttonBackgroundColor)
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 10)
                            .padding(.bottom)
                            
                            if let leaveIdError = submitViewModel.leaveIdError {
                                Text(leaveIdError)
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                    .foregroundColor(.red)
                            }
                            
                            if let errorMessage = submitViewModel.errorMessage {
                                Text(errorMessage)
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(
                            EdgeInsets(
                                top: 10,
                                leading: 20,
                                bottom: 10,
                                trailing: 20
                            )
                        )
                    }
                }
                .disabled(submitViewModel.isLoading)
                
                if submitViewModel.isLoading {
                    LoadingView()
                        .frame(width: 150, height: 150)
                }
                
            }
        }
        .onReceive(submitViewModel.$applySuccess) { applySuccess in
            if applySuccess {
                // Dismiss the view when shouldDismiss becomes true
                presentationMode.wrappedValue.dismiss()
                didUpdate = true
            }
        }
    }
}
