//
//  MyProfileView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 20/02/24.
//

import SwiftUI

struct MyProfileView: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        VStack {
            // ZStack {
            Image("backgroundImage")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                .background(Color.black)
                .clipped()
                .overlay(
                    HStack(alignment: .center) {
                        Image("suresh")
                            .resizable()
                        //.placeholder(Image("profilePic"))
                        //.indicator(.activity)
                        // .transition(.fade(duration: 0.5))
                            .scaledToFill()
                            .frame(width: 100)
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                            .clipShape(Circle())
                        
                        Button {
                                                  print("")
                                              } label: {
                                                  Image("Pencil")
                                                      .resizable()
                                                      .frame(width: 20.0, height: 20.0)
                                                      .padding(.trailing, 22)
                                                      .padding(.top, 14)
                                              }
                        
                        /*  if showExpose {
                         
                         WebImage(url: URL(string: profile.photo))
                         .onSuccess { image, data, cacheType in
                         }
                         .resizable()
                         .placeholder(Image("profilePic"))
                         .indicator(.activity)
                         .transition(.fade(duration: 0.5))
                         .scaledToFill()
                         .frame(width: 100)
                         .overlay(Circle().stroke(Color.white, lineWidth: 5))
                         .clipShape(Circle())
                         
                         } else {
                         WebImage(url: URL(string: profile.photo))
                         .onSuccess { image, data, cacheType in
                         }
                         .resizable()
                         .placeholder(Image("profilePic"))
                         .indicator(.activity)
                         .transition(.fade(duration: 0.5))
                         .scaledToFill()
                         .frame(width: 100)
                         .overlay(Circle().stroke(Color.white, lineWidth: 5))
                         .clipShape(Circle())
                         
                         }*/
                    }
                        .frame(height: 100, alignment: .center)
                        .offset(y: 75)
                )
            Spacer()
            
        VStack(alignment: .leading) {
            Text("Your Name")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )

            TextField("E-mail or id", text: $vm.username)
                //.foregroundColor(.black)
                .textInputAutocapitalization(.never)
                .baselineOffset(-2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            Divider()
                
               // .frame(height: 1)
              //  .padding(.horizontal, 30)
                .background(Color.gray)
            Text("User Name")
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            TextField("E-mail or id", text: $vm.username)
                .textInputAutocapitalization(.never)
                .baselineOffset(-2)
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.gray)
            
            Text("Email")
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            TextField("E-mail or id", text: $vm.username)
                .textInputAutocapitalization(.never)
                .baselineOffset(-2)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.gray)
            Text("Password")
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            TextField("E-mail or id", text: $vm.username)
                .textInputAutocapitalization(.never)
                .baselineOffset(-2)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.gray)
            Text("Date of Birth")
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            TextField("Date of Birth", text: $vm.username)
                .textInputAutocapitalization(.never)
                .baselineOffset(-2)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.gray)
            Text("Phone Number")
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            TextField("E-mail or id", text: $vm.username)
                .textInputAutocapitalization(.never)
                .baselineOffset(-2)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.gray)
            Text("XXXXX XXXXX")
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            TextField("E-mail or id", text: $vm.username)
                .textInputAutocapitalization(.never)
                .baselineOffset(-2)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.gray)
            Text("XXXXX XXXXX XXXXX")
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            TextField("E-mail or id", text: $vm.username)
                .textInputAutocapitalization(.never)
                .baselineOffset(-2)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 5
                    )
            )
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(Color.gray)
            
            
        }
    
    }
        .cornerRadius(20) /// make the background rounded
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue, lineWidth: 5)
        )
//            .baselineOffset(-2)
//        

    }
}

#Preview {
    MyProfileView()
}
