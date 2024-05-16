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
    @Binding var currentKey: APIKey?

    var body: some View {
        NavigationStack {
            
            Form {
                Picker("API Key", selection: $currentKey) {
                    ForEach(keys) { key in
                        Text(key.name).tag(key as APIKey?)
                    }
                    if keys.first == nil {
                        Text("None")
                    }
                }
                TextField("Enter Text for Vestaboard", text: $viewModel.boardText)
                Button {
                    guard let selectedKey = currentKey else {
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
    SendView(currentKey: .constant(nil))
}
