//
//  NewKeyView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/13/24.
//

import SwiftUI
import SwiftData

struct NewKeyView: View {
    @Environment(\.modelContext) private var modelContext
    @State var name = ""
    @State var key = ""
    @Binding var shown: Bool
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Read/Write API Key", text: $key)
            Button {
                AddKey(name: name, key: key)
                shown = false
            } label: {
                Text("Add Key")
            }
        }
    }
    func AddKey(name: String, key: String) {
        withAnimation {
            let newKey = APIKey(id: UUID(), name: name, key: key)
            modelContext.insert(newKey)
        }
    }
}
