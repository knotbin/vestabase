//
//  ContentView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        TabView {
            SendView()
                .tabItem {
                    Label("Send", systemImage: "message.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
