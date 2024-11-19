//
//  ClaimSubmitView.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 01/11/24.
//

import SwiftUI

struct ClaimSubmitView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ClaimManagementViewModel
    
    @State private var claimAmount: String = ""
    @State private var description: String = ""
    @State private var attachmentName: String = ""
    @Binding var selectedClaimItem: ClaimType?
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @StateObject private var submitViewModel = ClaimSubmitViewModel()

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
                
                Text("Apply Claim")
                    .foregroundColor(Color.primaryColor)
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
                            ForEach(viewModel.claimTypeData) { item in
                                ClaimBoxView(item: item, selectedItem: $selectedClaimItem)
                                    .listRowInsets(EdgeInsets())
                                    .onTapGesture {
                                        selectedClaimItem = item
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
                                    .foregroundColor(Color.primaryColor)
                                
                                Divider()
                                    .padding(.horizontal, 10)
                                    .background(Color.gray)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 20) {
                                TextField("Claim Amount", text: $submitViewModel.claimAmount)
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                
                                Divider()
                                    .padding(.horizontal, 10)
                                    .background(Color.gray)
                                
                                if let claimAmountError = submitViewModel.claimAmountError {
                                    Text(claimAmountError)
                                        .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                        .foregroundColor(.red)
                                }
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
                                submitViewModel.detectedImage = selectedImage
                                if let claimId = selectedClaimItem?.value {
                                    submitViewModel.claimId = "\(claimId)"
                                }
                                submitViewModel.postApplyClaim()
                            }) {
                                Text("APPLY")
                                    .font(Fonts.custom(Fonts.CustomFont.brownBold, size: 14))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.primaryColor)
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 10)
                            .padding(.bottom)
                            
                            if let claimIdError = submitViewModel.claimIdError {
                                Text(claimIdError)
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
            }
        }
    }
}
