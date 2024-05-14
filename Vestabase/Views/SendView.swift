//
//  SendView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/13/24.
//

import SwiftUI
import SwiftData

struct SendView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var keys: [APIKey]
    @State var boardText = ""

    var body: some View {
        Form {
            TextField("Enter Text for Vestaboard", text: $boardText)
                .textFieldStyle(.roundedBorder)
            Button {
                guard let apiKey = keys.first else {
                    print("No API key")
                    return
                }
                postMessage(withText: boardText, usingApiKey: apiKey.key)
                print(apiKey.key)
                boardText = ""
            } label: {
                Text("Send")
            }
        }
    }
    func postMessage(withText text: String, usingApiKey apiKey: String) {
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
}

#Preview {
    SendView()
}
