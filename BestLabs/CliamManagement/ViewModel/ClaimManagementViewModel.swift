//
//  LeaveManagementViewModel.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/09/24.
//

import Foundation
import SwiftUI
import Combine

class ClaimManagementViewModel: ObservableObject {
    @Published var claimTypeData: [ClaimType] = []
    @Published var claimRequestData: [ClaimResponse.Claim] = []
    @Published var claimApprovalData: [ClaimResponse.Claim] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var claimId: String = ""
    @Published var actionType: String = ""
    @Published var remarks: String = ""
    @Published var applySuccess: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(claimTypeData: [ClaimType], claimRequestData: [ClaimResponse.Claim], claimApprovalData: [ClaimResponse.Claim], errorMessage: String? = nil, isLoading: Bool = false, cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.claimTypeData = claimTypeData
        self.claimRequestData = claimRequestData
        self.claimApprovalData = claimApprovalData
        self.errorMessage = errorMessage
        self.isLoading = isLoading
        self.claimId = claimId
        self.actionType = actionType
        self.remarks = remarks
        self.applySuccess = applySuccess
        self.cancellables = cancellables
    }
    
    func getClaimTypeData() {

        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.claimlistUrl.rawValue
        guard URL(string: url) != nil else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        
        let headers = ["authorization": token]
        
        let networkManager = NetworkManager.shared
        
        var components = URLComponents(string: url)
        
        components?.queryItems = [
            URLQueryItem(name: "empID", value: empIDStr),
            URLQueryItem(name: "clientID", value: clientIDStr),
            URLQueryItem(name: "viewtype", value: "dropdown")
        ]
        
        guard let finalURL = components?.url else {
            errorMessage = "Invalid URL components"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchData(
            url: finalURL,
            method: .get,
            headers: headers,
            responseType: ClaimTypeResponse.self
        )
        .sink { completion in
            self.isLoading = false
//            self.didLoad = true
            
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
    
            guard data.status == "success" else {
                self?.errorMessage = "Failed. Please Try Again"
                return
            }
            
            self?.claimTypeData = data.result
        }
        .store(in: &cancellables)
    }
    
    func getClaimRequestData() {
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.claimrequestlistUrl.rawValue
        guard URL(string: url) != nil else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        
        let headers = ["authorization": token]
        
        let networkManager = NetworkManager.shared
        
        var components = URLComponents(string: url)
        
        components?.queryItems = [
            URLQueryItem(name: "empID", value: empIDStr),
            URLQueryItem(name: "clientID", value: clientIDStr)
        ]
        
        guard let finalURL = components?.url else {
            errorMessage = "Invalid URL components"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchData(
            url: finalURL,
            method: .get,
            headers: headers,
            responseType: ClaimResponse.self
        )
        .sink { completion in
            self.isLoading = false
//            self.didLoad = true
            
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
    
            guard data.status == "ok" else {
                self?.errorMessage = "Failed. Please Try Again"
                return
            }
            
            self?.claimRequestData = data.result ?? []
        }
        .store(in: &cancellables)
    }
    
    
    func getClaimApprovalData() {
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.claimApprovalListUrl.rawValue
        guard URL(string: url) != nil else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        
        let headers = ["authorization": token]
        
        let networkManager = NetworkManager.shared
        
        var components = URLComponents(string: url)
        
        components?.queryItems = [
            URLQueryItem(name: "empID", value: empIDStr),
            URLQueryItem(name: "clientID", value: clientIDStr),
            URLQueryItem(name: "clientID", value: clientIDStr),
            URLQueryItem(name: "clientID", value: clientIDStr)
        ]
        
        guard let finalURL = components?.url else {
            errorMessage = "Invalid URL components"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchData(
            url: finalURL,
            method: .get,
            headers: headers,
            responseType: ClaimResponse.self
        )
        .sink { completion in
            self.isLoading = false
//            self.didLoad = true
            
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
    
            guard data.status == "ok" else {
                self?.errorMessage = "Failed. Please Try Again"
                return
            }
            
            self?.claimApprovalData = data.result ?? []
        }
        .store(in: &cancellables)
    }
    
    func postApproveClaim() {
       
        let url = Constants.baseUrl.rawValue + Constants.claimUpdatestatus.rawValue
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
            "ClaimID": claimId,
            "actionType": actionType,
            "remarks": remarks
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
            responseType: LeaveApplyResponse.self
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
            guard data.status == "success" else {
                self?.errorMessage = "Failed. Please Try Again"
                return
            }
            
            self?.applySuccess = true
            self?.getClaimApprovalData()
            
        }
        .store(in: &cancellables)
    }
}

