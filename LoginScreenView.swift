//
//  LoginView.swift
//  Login Template
//
//  Created by Suresh Swaminathan on 24/02/24.
//

import SwiftUI

struct LoginScreeenView: View {
    @StateObject var vm = ViewModel()
    @State var navigated = false
    var body: some View {
        
        NavigationStack {
        if vm.authenticated {
            ZStack {
       
                Rectangle()
                    .background(Color.black)
                Image("splashscreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        

            
            
            
            
            // Show the view you want users to see when logged on
            VStack(spacing: 20) {
                Text("Welcome back **\(vm.username.lowercased())**!")
                Text("Today is: **\(Date().formatted(.dateTime))**")
                Button("Log out", action: vm.logOut)
                    .tint(.red)
                    .buttonStyle(.bordered)
            }
        } else {
            // Show a login screen
            VStack {
           
                Image("splashscreen")
                    .resizable()
                   // .cornerRadius(20)
                .ignoresSafeArea()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
               .frame(maxHeight: 200)
                Spacer()
           
                VStack(alignment: .leading, spacing: 20) {
                    
                        
                    Spacer()
                    Text("Welcome").bold().font(.title)
                    
                    Text("Login to Continue")
                    .font(.subheadline)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            
                    TextField("E-mail or id", text: $vm.username)
                      //  .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .baselineOffset(-2)
                    
                    Divider()
                    // .frame(height: 1)
                     .padding(.horizontal, 30)
                     .background(Color.gray)
                       
//                    Divider()
//                                   .padding(.horizontal, 30)
                    SecureField("Password", text: $vm.password)
                       // .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .privacySensitive()
                    Divider()
                     .frame(height: 1)
                     .padding(.horizontal, 30
                              
                     )
                     .background(Color.gray)
                   /* Button("Log on",role: .cancel, action: vm.authenticate)
                        .buttonStyle(.bordered)
                    */
                 
                    Button(action: { self.navigated.toggle()}) {
                                   Text("Login")
                                   .fontWeight(.heavy)
                                   .font(.title3)
                                   .frame(maxWidth: .infinity)
                                   .padding()
                                   .foregroundColor(.white)
                                   .background(.black)
                                  // .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                                   .cornerRadius(40)
                               }
                    
//                        Button(action: {
//                            self.navigated.toggle()
//
//                            
//                        }) 
//                        .frame(height: 50)
//                        .frame(maxWidth: .infinity)
//                        .background(.black
//    //                       LinearGradient(colors: [.blue, .red],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
//                        )
//                        .cornerRadius(20)
//                      //  .padding()
//                     //
//                        {
//                        label: do {
//                            Text("Login")
//                            .font(.title2)
//                            .bold()
//                            .foregroundColor(.white)
//                         }
//                       
//                            
//                            
                            
                            
                            
                            
                            
                   //     }
                    
                    
                         /*    NavigationLink("MainTabbedView", destination: MainTabbedView(), isActive: $navigated)

                             Button(action: { self.navigated.toggle() },
                                   
                   label: {
                      Text("Login")
                      .font(.title2)
                      .bold()
                      .foregroundColor(.white)
                    })
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.black
//                       LinearGradient(colors: [.blue, .red],                   startPoint: .topLeading,                   endPoint: .bottomTrailing) // how to add a gradient to a button in SwiftUI
                    )
                    .cornerRadius(20)
                    .padding()
                    
                    */
                    HStack {
//Spacer()
                        Button("Forgot password?", action: vm.logPressed)
//                            .tint(.red.opacity(0.80))
                            .tint(.black)
                        Spacer()
                        Button("Sign Up", action: vm.logPressed)
//.tint(.red.opacity(0.80))
                            .tint(.black)
                      //  Spacer()
                    }
                    Spacer()
                }
               
                .alert("Access denied", isPresented: $vm.invalid) {
                    Button("Dismiss", action: vm.logPressed)
                }
                .frame(width: 300)
                .padding()
                
            }
           
         
         .transition(.offset(x: 0, y: 850))
            
            .navigationDestination(isPresented: $navigated, destination: { MainTabbedView() })
        }
            
        }
       
    }
}
    


#Preview {
    LoginScreenView()
}
