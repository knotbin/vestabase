//
//  SendViewModel.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/14/24.
//

import Foundation
import SwiftData

class SendViewModel: ObservableObject {
    @Published var boardText = ""
    @Published var showAlert = false
    
    public func postMessage(withText text: String, usingApiKey apiKey: String) {
        let url = URL(string: "https://rw.vestaboard.com/")!
        
        let parameters: [String: Any] = ["text": text]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error: Unable to serialize JSON")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "X-Vestaboard-Read-Write-Key")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 {
                    print("Data was sent successfully")
                } else {
                    print("Failed to send data with status code: \(httpResponse.statusCode)")
                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        print("Response data: \(responseString)")
                    }
                }
            } else {
                print("Error: Invalid response received")
            }
        }

        task.resume()
    }
    
    init() {}
}
