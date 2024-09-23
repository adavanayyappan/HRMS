//
//  DashboardViewModel.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 24/07/24.
//

import Foundation
import SwiftUI
import Combine

class DashboardViewModel: ObservableObject {
    @Published var data: PunchStatusResponse?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func getTimeSheetStatus() {
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.punchingstatusUrl.rawValue
        guard let urls = URL(string: url) else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        
        let headers = ["Authorization": token]
        
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
            responseType: PunchStatusResponse.self
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
            
            self?.data = data
            
        }
        .store(in: &cancellables)
           
    }
}

