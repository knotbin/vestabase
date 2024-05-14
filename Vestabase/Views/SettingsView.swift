//
//  SettingsView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/13/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query private var keys: [APIKey]
    
    @State var sheetShown = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(keys) { keyItem in
                    Text(keyItem.name)
                }
            }
            .navigationTitle("API Keys")
            .toolbar {
                ToolbarItem {
                    Button {
                        sheetShown = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $sheetShown, content: {
                NewKeyView(shown: $sheetShown)
            })
        }

    }
}

#Preview {
    SettingsView()
}
