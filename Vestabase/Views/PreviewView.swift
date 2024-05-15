//
//  PreviewView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/15/24.
//

import SwiftUI
import SwiftData

struct PreviewView: View {
    var currentKey: APIKey?
    
    let data: [Int] = [
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 46, 47, 48, 49, 50, 52, 53, 54, 55, 56, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 46, 47, 48, 49, 50, 52, 53, 54, 55, 56, 59, 60, 
    ]
    
    @StateObject var viewModel = PreviewViewModel()
    
    var body: some View {
        VStack {
            if viewModel.code != nil {
                LazyVGrid(columns: viewModel.layout, spacing: 5) {
                    ForEach(viewModel.assignUnique(values: data)) { character in
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
                ContentUnavailableView("No API Key Selected", systemImage: "key.slash.fill", description: Text("Please select an API key or add one in settings to view a preview of your Vestaboard"))
            }
        }
        .onAppear(perform: {
            Task {
                guard let key = currentKey else {
                    print("No API Key")
                    return
                }
                await viewModel.code = viewModel.getMessage(apiKey: key)
            }
        })
    }

}

#Preview {
    PreviewView()
}
