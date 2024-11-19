//
//  LoginViewModel.swift
//  BestLabs
//
//  Created by Suresh Swaminathan on 27/02/24.
//

import Foundation
import SwiftUI
import Combine

class ChangePasswordViewModel: ObservableObject {
    var data: ChangePasswordModel?
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var confirmPasswordError: String?
    @Published var passwordError: String?
    @Published var isFormValid: Bool = false
    @Published var passwordSuccess: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
            Publishers.CombineLatest($confirmPassword, $password)
                .map { confirmPassword, password in
                    return !confirmPassword.isEmpty && !password.isEmpty && password.count > 6 && password == confirmPassword
                }
                .assign(to: \.isFormValid, on: self)
                .store(in: &cancellables)
    }
    
    func postLoginData() {
        
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
        
        let url = Constants.baseUrl.rawValue + Constants.changePasswordUrl.rawValue
        guard let url = URL(string: url) else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let headers = ["Authorization" : token]
        
        let formData = [
            "empID": empIDStr,
            "clientID": clientIDStr,
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
            headers: headers,
            body: formBody,
            responseType: ChangePasswordModel.self
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
                self?.errorMessage = "Change Password Failed. Please Try Again"
                return
            }
            
            self?.passwordSuccess = true
        }
        .store(in: &cancellables)
           
    }
}
