//
//  SettingsView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/13/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var keys: [APIKey]
    
    @State var sheetShown = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(keys) { keyItem in
                    Text(keyItem.name)
                        .contextMenu(ContextMenu(menuItems: {
                            Button(role: .destructive) {
                                deleteKey(key: keyItem)
                            } label: {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }))
                }
                .onDelete(perform: { indexSet in
                    deleteItem(offsets: indexSet)
                })

                
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
    func deleteItem(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(keys[index])
            }
        }
    }
    func deleteKey(key: APIKey) {
        withAnimation {
            modelContext.delete(key)
        }
    }
}

#Preview {
    SettingsView()
        .modelContainer(for: APIKey.self, inMemory: true)
}
