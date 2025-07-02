//
//  LoginViewModel.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    var data: LoginUserModel?
//    @Published var username: String = "98765432"
//    @Published var password: String = "Password@123"
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var isFormValid: Bool = false
    @Published var loginSuccess: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
            Publishers.CombineLatest($username, $password)
                .map { username, password in
                    return !username.isEmpty && !password.isEmpty && password.count > 6
                }
                .assign(to: \.isFormValid, on: self)
                .store(in: &cancellables)
    }
    
    func postLoginData() {
        
        $username
            .map { username in
                return !username.isEmpty ? nil : "Enter email address/ mobile number"
            }
            .assign(to: \.emailError, on: self)
            .store(in: &cancellables)
        
        $password
            .map { password in
                return !password.isEmpty ? nil : "Enter valid password"
            }
            .assign(to: \.passwordError, on: self)
            .store(in: &cancellables)
        
        let url = Constants.baseUrl.rawValue + Constants.loginUrl.rawValue
        guard let url = URL(string: url) else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        
        let formData = [
            "userName": username,
            "password": password
        ]
        
        let networkManager = NetworkManager.shared
        
        guard let formBody = networkManager.createFormBody(from: formData) else { return }
        
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchData(
            url: url,
            method: .post,
            body: formBody,
            responseType: LoginUserModel.self
        )
        .sink { completion in
            self.isLoading = false
            
            switch completion {
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    self.errorMessage = networkError.localizedDescription
                    print("Failed with error: \(networkError.localizedDescription)")
                } else {
                    self.errorMessage = error.localizedDescription
                    print("Failed with error: \(error.localizedDescription)")
                }
            case .finished:
                break
            }
        } receiveValue: { [weak self] data in
            print("Received response: \(data)")
            
            self?.data = data
            
            guard let data = self?.data, data.status == "ok", let result = data.result else {
                self?.errorMessage =  (data.message != nil) ? data.message : "Login Failed. Please Try Again"
                return
            }
            
            AppStorageManager.setValue(result.token, forKey: AppStorageKeys.KEY_TOKEN)
            AppStorageManager.setValue(result.employeeID, forKey: AppStorageKeys.KEY_EMP_ID)
            AppStorageManager.setValue(result.employeeClientID, forKey: AppStorageKeys.KEY_CLIENT_ID)
            AppStorageManager.setValue(result.employeeName, forKey: AppStorageKeys.KEY_NAME)
            AppStorageManager.setValue(result.faceImage, forKey: AppStorageKeys.KEY_EMP_IMAGE)
            
            self?.loginSuccess = true
        }
        .store(in: &cancellables)
           
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

