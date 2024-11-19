//
//  LeaveSubmitViewModel.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 23/09/24.
//

import Foundation
import SwiftUI
import Combine

class LeaveSubmitViewModel: ObservableObject {
    @Published var leaveId: String = ""
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    @Published var description: String = ""
    @Published var detectedImage: UIImage?
    @Published var descriptionError: String?
    @Published var leaveIdError: String?
    @Published var applySuccess: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
    }
    
    func postApplyLeave() {
        
        $description
            .map { username in
                return !username.isEmpty ? nil : "Enter description"
            }
            .assign(to: \.descriptionError, on: self)
            .store(in: &cancellables)
        
        $leaveId
            .map { username in
                return !username.isEmpty ? nil : "Select Leave Category"
            }
            .assign(to: \.leaveIdError, on: self)
            .store(in: &cancellables)
        
        guard !description.isEmpty && !leaveId.isEmpty else {
            return
        }
        
        guard let detectedImage else {
            
            let url = Constants.baseUrl.rawValue + Constants.leaveApply.rawValue
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
                "leaveTypeID": leaveId,
                "fromDate": startDate,
                "toDate": endDate,
                "remarks": description,
                "coWorkerEmailID": "mailto:test3@gmail.com"
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
                
            }
            .store(in: &cancellables)
            
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.leaveApply.rawValue
        let imageUrl = URL(string: url)!
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let parameters = ["empID": empIDStr,
                          "clientID": clientIDStr,
                          "leaveTypeID": leaveId,
                          "fromDate": startDate,
                          "toDate": endDate,
                          "remarks": description,
                          "coWorkerEmailID": "mailto:test3@gmail.com"]
        
        let headers = ["Authorization" : token]
        
        isLoading = true
        errorMessage = nil
        
        ImageFetcher.uploadImage(url: imageUrl, image: detectedImage, fileName: "leaveDoc", parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                // Handle success
                print("Upload successful: \(data)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    do {
                        let response = try JSONDecoder().decode(LeaveApplyResponse.self, from: data)
                        print("Status: \(response.status)")
                        guard response.status == "success" else {
                            self.errorMessage = "Failed. Please Try Again"
                            return
                        }
                        
                        self.applySuccess = true
                        
                    } catch {
                        print("Decoding failed: \(data)")
                        self.errorMessage = "Failed. Please Try Again"
                       
                    }
                }
            case .failure(let error):
                // Handle error
                print("Apply failed: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Failed. Please Try Again"
                }
            }
        }
           
    }

}


