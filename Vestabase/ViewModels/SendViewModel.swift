//
//  SendViewModel.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/14/24.
//

import Foundation
import SwiftData

class SendViewModel: ObservableObject {
    @Published var boardText = ""
    @Published var showAlert = false
    @Published var currentKey: APIKey? = nil
    
    init() {}
}
