//
//  Timer.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 11/03/24.
//

import SwiftUI

struct Timer: View {
    var data = ["08.00 AM ", "--:--", "08.00 PM"]

    var body: some View {
    VStack {
        HStack {
            ForEach(data, id: \.self) { item in
                VStack{
                    Image("clock")
                    Text(item)
                        .frame(maxWidth: .infinity)
                        //.foregroundColor(.nblue)
                    
                }
                .foregroundColor(.black)
            }
        }
    }
    }
}

