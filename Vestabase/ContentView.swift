//
//  ContentView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var boardText = ""
    @State var apiKey = ""

    var body: some View {
        VStack {
            TextField("Enter Vestaboard Read/Write API Key", text: $apiKey)
                .textFieldStyle(.roundedBorder)
            TextField("Enter Text for Vestaboard", text: $boardText)
                .textFieldStyle(.roundedBorder)
            Button {
                postMessage(withText: boardText, usingApiKey: apiKey)
                boardText = ""
            } label: {
                Text("Send")
            }
        }
        .padding(50)
    }
    func postMessage(withText text: String, usingApiKey apiKey: String) {
        let url = URL(string: "https://rw.vestaboard.com/")!
        
        let parameters: [String: Any] = ["text": text]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error: Unable to serialize JSON")
            return
        }

        // Create a URLRequest object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "X-Vestaboard-Read-Write-Key")
        request.httpBody = jsonData

        // Create and configure a URLSession data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "No error description available.")")
                return
            }

            // Handle the data and response status code here
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Data was sent successfully")
            } else {
                print("Failed to send data")
            }
        }

        // Execute the task
        task.resume()
    }
}

#Preview {
    ContentView()
}
