//
//  TimesheetViewModel.swift
//  BestLabs
//
//  Created by Adavan Ayyappan on 29/06/24.
//

import Foundation
import SwiftUI
import Combine

class TimesheetViewModel: ObservableObject {
    @Published var data: [TimeEntry] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func getTimeSheetData() {
        
        let token: String = AppStorageManager.value(forKey: AppStorageKeys.KEY_TOKEN, defaultValue: "")
        let empID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_EMP_ID, defaultValue: 0)
        let clientID: Int = AppStorageManager.value(forKey: AppStorageKeys.KEY_CLIENT_ID, defaultValue: 0)
        
        guard let empIDStr = BaseStringConverter.intToBase64String(empID),
              let clientIDStr = BaseStringConverter.intToBase64String(clientID) else {
            return
        }
        
        let url = Constants.baseUrl.rawValue + Constants.timeSheetUrl.rawValue
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
            responseType: TimeEntryResponse.self
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
            
            self?.data = data.result
            
        }
        .store(in: &cancellables)
    }
}
