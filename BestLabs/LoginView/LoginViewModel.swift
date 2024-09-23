//
//  LoginViewModel.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import Foundation

import SwiftUI

extension LoginScreenView{
//extension ContentView {
    class ViewModel: ObservableObject {
        @AppStorage("AUTH_KEY") var authenticated = false {
            willSet { objectWillChange.send() }
        }
        @AppStorage("USER_KEY") var username = ""
        // Keep filled ONLY for debugging
        @Published var password = "" // Keep filled ONLY for debugging
        @Published var invalid: Bool = false
        
        private var sampleUser = "username"
        private var samplePassword = "password"
        
        init() {
            // Debugging
            print("Currently logged on: \(authenticated)")
            print("Current user: \(username)")
        }
        
        func toggleAuthentication() {
            // Make sure that the password does not save.
            self.password = ""
            
            withAnimation(.spring()) {
                authenticated.toggle()
            }
        }

        func authenticate() {
            // Check for user
            guard self.username.lowercased() == sampleUser else {
                self.invalid = true
                return }
            
            // Check for password
            guard self.password.lowercased() == samplePassword else {
                self.invalid = true
                return }
            
            toggleAuthentication()
        }
        
        func logOut() {
            toggleAuthentication()
        }
        
        func logPressed() {
            print("Button pressed.")
        }
    }
}

extension MyProfileView {
    class ViewModel: ObservableObject {
        @AppStorage("AUTH_KEY") var authenticated = false {
            willSet { objectWillChange.send() }
        }
        @AppStorage("USER_KEY") var username = ""
        // Keep filled ONLY for debugging
        @Published var password = "" // Keep filled ONLY for debugging
        @Published var invalid: Bool = false
        
        private var sampleUser = "username"
        private var samplePassword = "password"
        
        init() {
            // Debugging
            print("Currently logged on: \(authenticated)")
            print("Current user: \(username)")
        }
        
        func toggleAuthentication() {
            // Make sure that the password does not save.
            self.password = ""
            
            withAnimation(.spring()) {
                authenticated.toggle()
            }
        }

        func authenticate() {
            // Check for user
            guard self.username.lowercased() == sampleUser else {
                self.invalid = true
                return }
            
            // Check for password
            guard self.password.lowercased() == samplePassword else {
                self.invalid = true
                return }
            
            toggleAuthentication()
        }
        
        func logOut() {
            toggleAuthentication()
        }
        
        func logPressed() {
   
            print("Button pressed.")
        }
    }
}

