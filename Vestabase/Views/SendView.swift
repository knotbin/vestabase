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
    
    @StateObject var viewModel = SendViewModel()

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Message Info")) {
                    TextField("Enter Text for Vestaboard", text: $viewModel.boardText)
                    Picker("API Key", selection: $viewModel.currentKey) {
                        ForEach(keys) { key in
                            Text(key.name).tag(key as APIKey?)
                        }
                        if keys.first == nil {
                            Text("None")
                        }
                    }
                }
                
                Button {
                    guard let selectedKey = viewModel.currentKey else {
                        viewModel.showAlert = true
                        return
                    }
                    viewModel.postMessage(withText: viewModel.boardText, usingApiKey: selectedKey.key)
                    viewModel.boardText = ""
                } label: {
                    Text("Send")
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("No API Key Added"),
                message: Text("Please add your API Key(s) in the Settings menu")
            )
        }
    }
}

#Preview {
    SendView()
}
