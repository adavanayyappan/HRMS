//
//  LoginViewModel.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import Foundation
import SwiftUI
import Combine

class ForgotPasswordViewModel: ObservableObject {
    var data: ForgotPasswordModel?
    @Published var empEmailId: String = ""
    @Published var otp: String = ""
    @Published var receivedOTP: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var otpError: String?
    @Published var confirmPasswordError: String?
    @Published var forgotPasswordSuccess: Bool = false
    @Published var resetPasswordSuccess: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    var isResetPasswordValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.receivedOTP = data?.temp_otp ?? ""
    }
    
    func postForgotPasswordData() {
        
        $empEmailId
            .map { username in
                return !username.isEmpty ? nil : "Enter email address/ mobile number"
            }
            .assign(to: \.emailError, on: self)
            .store(in: &cancellables)
        
        if empEmailId.isEmpty {
            return
        }
        
    
        let url = Constants.baseUrl.rawValue + Constants.forgotPasswordUrl.rawValue
        guard let url = URL(string: url) else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        
        let formData = [
            "empEmailId": empEmailId
        ]
        
        let networkManager = NetworkManager.shared
        
        guard let formBody = networkManager.createFormBody(from: formData) else { return }
        
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchData(
            url: url,
            method: .post,
            body: formBody,
            responseType: ForgotPasswordModel.self
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
            
            guard let data = self?.data, data.status == "success"else {
                self?.errorMessage =  (data.message != nil) ? data.message : "Forgot Password Failed. Please Try Again"
                return
            }
            self?.forgotPasswordSuccess = true
        }
        .store(in: &cancellables)
           
    }
    
    func postResetPasswordData() {
        
        $empEmailId
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
        
        $confirmPassword
            .map { confirmPassword in
                return !confirmPassword.isEmpty ? nil : "Enter valid confirm password"
            }
            .assign(to: \.confirmPasswordError, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest($confirmPassword, $password)
            .map { confirmPassword, password in
                return password == confirmPassword ? nil : "Password and confirm password should be same"
            }
            .assign(to: \.confirmPasswordError, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest($otp, $receivedOTP)
            .map { otp, receivedOTP in
                return otp == receivedOTP ? nil : "Please enter valid otp"
            }
            .assign(to: \.otpError, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest4($confirmPassword, $password, $otp, $receivedOTP)
            .map { confirmPassword, password, otp, receivedOTP in
                return otp == receivedOTP && password == confirmPassword
            }
            .assign(to: \.isResetPasswordValid, on: self)
            .store(in: &cancellables)
        
        if !isResetPasswordValid {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.resetPasswordUrl.rawValue
        guard let url = URL(string: url) else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        
        let formData = [
            "empEmailId": empEmailId,
            "OTPKey": otp,
            "password": password,
            "cpassword": confirmPassword
        ]
        
        let networkManager = NetworkManager.shared
        
        guard let formBody = networkManager.createFormBody(from: formData) else { return }
        
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchData(
            url: url,
            method: .post,
            body: formBody,
            responseType: ForgotPasswordModel.self
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
            
            guard let data = self?.data, data.status == "success" else {
                self?.errorMessage =  (data.message != nil) ? data.message : "Reset Password Failed. Please Try Again"
                return
            }
            self?.forgotPasswordSuccess = true
        }
        .store(in: &cancellables)
           
    }
}
