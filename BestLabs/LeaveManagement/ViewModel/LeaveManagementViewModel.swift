//
//  LeaveManagementViewModel.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/09/24.
//

import Foundation
import SwiftUI
import Combine

class LeaveManagementViewModel: ObservableObject {
    @Published var leaveBalanceData: [LeaveBalance] = []
    @Published var leaveRequestData: [LeaveRequestListResponse.Leave] = []
    @Published var leaveApprovalData: [LeaveRequestListResponse.Leave] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var leaveId: String = ""
    @Published var actionType: String = ""
    @Published var remarks: String = ""
    @Published var applySuccess: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {}
    
    init(leaveBalanceData: [LeaveBalance], leaveRequestData: [LeaveRequestListResponse.Leave], leaveApprovalData: [LeaveRequestListResponse.Leave], errorMessage: String? = nil, isLoading: Bool = false) {
        self.leaveBalanceData = leaveBalanceData
        self.leaveRequestData = leaveRequestData
        self.leaveApprovalData = leaveApprovalData
        self.errorMessage = errorMessage
        self.isLoading = isLoading
    }
    
    func getLeaveTypeData() {

        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.leavelistUrl.rawValue
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
            responseType: LeaveBalanceResponse.self
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
            
            self?.leaveBalanceData = data.result
        }
        .store(in: &cancellables)
    }
    
    func getLeaveRequestData() {
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.leaverequestlistUrl.rawValue
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
            responseType: LeaveRequestListResponse.self
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
            
            self?.leaveRequestData = data.result ?? []
        }
        .store(in: &cancellables)
    }
    
    
    func getLeaveApprovalData() {
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.leaveApprovalListUrl.rawValue
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
            responseType: LeaveRequestListResponse.self
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
            
            self?.leaveApprovalData = data.result ?? []
        }
        .store(in: &cancellables)
    }
    
    func postApproveLeave() {
       
        let url = Constants.baseUrl.rawValue + Constants.leaveUpdatestatus.rawValue
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
            "leaveID": leaveId,
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
            self?.getLeaveApprovalData()
            
        }
        .store(in: &cancellables)
    }
}

