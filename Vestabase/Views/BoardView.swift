//
//  BoardView.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/15/24.
//

import SwiftUI
import SwiftData

struct BoardView: View {
    @Query var keys: [APIKey]
    @StateObject var viewModel = BoardViewModel()
    
    var body: some View {
        VStack {
            SendView(currentKey: $viewModel.currentKey)
            PreviewView(currentKey: viewModel.currentKey)
        }
        .onAppear() {
            viewModel.currentKey = keys.first
        }
    }
}

#Preview {
    BoardView()
}
