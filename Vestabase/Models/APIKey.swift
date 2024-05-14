//
//  APIKey.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/13/24.
//

import Foundation
import SwiftData

@Model
class APIKey {
    var id: UUID
    var name: String
    var key: String
    
    init(id: UUID, name: String, key: String) {
        self.id = id
        self.name = name
        self.key = key
    }
}
