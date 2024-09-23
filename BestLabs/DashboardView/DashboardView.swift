//
//  DashboardView.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 11/03/24.
//

import SwiftUI



struct DashboardView: View {
      
  

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                VStack {
                    HeaderBanner()
                    
                    
                    ProfileText()
                        .padding(
                            EdgeInsets(
                                top: 25,
                                leading: 10,
                                bottom: 0,
                                trailing: 10
                            )
                        )
                    
                }
                
            }
        }
    }
    }

struct ProfileText: View {
    //        @AppStorage("name") var name = DefaultSettings.name
    //        @AppStorage("subtitle") var subtitle = DefaultSettings.subtitle
    //        @AppStorage("description") var description = DefaultSettings.description

    
    var body: some View {
        ZStack {
            VStack() {
               // Spacer()
            
            Text("Attendance")
                .bold()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(alignment: .center) {
                
                Text("09.00 AM")
                    .bold()
                    .font(.title)
                    .foregroundColor(.black)
                Text("Mon, Mar 24")
                    .foregroundColor(.black)
                //                        .bold()
                //                        .font(.title)
//                Image("face")
//                    .symbolRenderingMode(.palette)
//                       .foregroundStyle(
//                        .black)
//                       
//                   .foregroundColor(.black)
                //.frame(width: 200, height: 200)
                //                        .scaledToFit()
                //                        .clipShape(Circle())
                //                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                //                        .shadow(radius: 10)
                
                
                
                
                
            }
            .foregroundColor(.black)
            .frame(width: 250, height: 250)
            //  .background(.blue)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
            .padding(
                EdgeInsets(
                    top: 25,
                    leading: 10,
                    bottom: 0,
                    trailing: 10
                )
            )
            
            
            /*
             VStack(spacing: 15) {
             VStack(spacing: 5) {
             Text("name")
             .bold()
             .font(.title)
             Text("subtitle")
             .font(.body)
             .foregroundColor(.secondary)
             }.padding()
             Text("description")
             .multilineTextAlignment(.center)
             .padding()
             Spacer()
             }*/
            /* Timer */
            //  ZStack(alignment: .bottom) {
            VStack {
                let data = ["08.00 AM ", "--:--", "08.00 PM"]
                // This will be as small as possible to fit the data
                //        HStack {
                //            ForEach(data, id: \.self) { item in
                //                Text(item)
                //                    .border(Color.red)
                //            }
                //        }
                
                // The frame modifier allows the view to expand horizontally
                HStack {
                    ForEach(data, id: \.self) { item in
                        VStack{
                            Image("clock")
                            //                        .frame(width: 100, height: 100)
                            //                        .scaledToFit()
                            //                        .clipShape(Circle())
                            //                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            //                        .shadow(radius: 10)
                            
                            Text(item)
                                .frame(maxWidth: .infinity-75
                                )
                            // .border(Color.red)
                        }
                    }
                }
                .frame(height: 125)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                )
            }
            .padding(
                EdgeInsets(
                    top: 25,
                    leading: 10,
                    bottom: 25,
                    trailing: 10
                )
            )
            //   }
            
            
        }
    }
}
    }
