//
//  PreviewView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/15/24.
//

import SwiftUI
import SwiftData

struct PreviewView: View {
    @Query var keys: [APIKey]
    var currentKey: APIKey?

    
    @StateObject var viewModel = PreviewViewModel()
    
    var body: some View {
        VStack {
            if viewModel.code != nil {
                LazyVGrid(columns: viewModel.layout, spacing: 5) {
                    ForEach(viewModel.assignUnique(values: viewModel.code!)) { character in
                        if let text = viewModel.codemap[character.value] {
                            if let color = viewModel.colorMap[text] {
                                Color(color)
                            } else {
                                Text(text)
                                    .font(.system(size: 11))
                            }
                        }
                    }
                    .frame(height: 17)
                }
                .padding()
            } else {
                if viewModel.firstLoad {
                    ProgressView()
                } else {
                    ContentUnavailableView("No API Key Selected", systemImage: "key.slash.fill", description: Text("Please select an API key or add one in settings to view a preview of your Vestaboard"))
                }
            }
            Button {
                Task {
                    await viewModel.getMessage(key: currentKey)
                }
            } label: {
                Image(systemName: "arrow.clockwise")
            }
        }
        .onAppear(perform: {
            Task {
                await viewModel.getMessage(key: keys.first)
                viewModel.firstLoad = false
            }
        })
    }

}

#Preview {
    PreviewView()
}
