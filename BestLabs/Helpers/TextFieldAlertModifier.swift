//
//  TextFieldAlertModifier.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 01/11/24.
//
import SwiftUI

extension View {
    func textFieldAlert(isPresented: Binding<Bool>, text: Binding<String>) -> some View {
        self.modifier(TextFieldAlertModifier(isPresented: isPresented, text: text))
    }
}

struct TextFieldAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var text: String

    func body(content: Content) -> some View {
        content
            .background(
                Group {
                    if isPresented {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                isPresented = false
                            }
                        VStack {
                            Text("Enter Remark")
                                .font(.headline)
                                .padding()

                            TextField("Your remark...", text: $text)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            HStack {
                                Button("Cancel") {
                                    isPresented = false
                                }
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)

                                Button("OK") {
                                    // Handle the OK action
                                    print("User Input: \(text)")
                                    isPresented = false
                                }
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .padding()
                        }
                        .frame(width: 300, height: 200)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding(.horizontal, 40)
                    }
                }
            )
    }
}
