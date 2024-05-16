//
//  BoardViewModel.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/15/24.
//

import Foundation

class BoardViewModel: ObservableObject {
    @Published var currentKey: APIKey? = nil
    
    init() {}
}
