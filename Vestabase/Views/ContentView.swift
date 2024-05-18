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
            BoardView()
                .tabItem {
                    Label("Board", systemImage: "clipboard")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
