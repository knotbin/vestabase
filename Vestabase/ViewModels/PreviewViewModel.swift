//
//  PreviewViewModel.swift
//  Vestabase
//
//  Created by Roscoe Rubin-Rottenberg on 5/15/24.
//

import Foundation
import SwiftUI

class PreviewViewModel: ObservableObject {
    @Published var code: [Int]? = nil
    public let layout = Array(repeating: GridItem(.adaptive(minimum:50)), count: 22)
    
    let codemap = [
        0: "", 1: "A", 2: "B", 3: "C", 4: "D", 5: "E", 6: "F", 7: "G", 8: "H", 9: "I", 10: "J", 11: "K", 12: "L", 13: "M", 14: "N", 15: "O", 16: "P", 17: "Q", 18: "R", 19: "S", 20: "T", 21: "U", 22: "V", 23: "W", 24: "X", 25: "Y", 26: "Z",
        27: "1", 28: "2", 29: "3", 30: "4", 31: "5", 32: "6", 33: "7", 34: "8", 35: "9", 36: "0", 37: "!", 38: "@", 39: "#", 40: "$", 41: "(", 42: ")", 44: "-", 46: "+", 47: "&", 48: "=", 49: ";", 50: ":", 52: "'", 53: "\"", 54: "%", 55: ",", 56: ".", 59: "/", 60: "?",
        62: "°", 63: "PoppyRed", 64: "Orange", 65: "Yellow", 66: "Green", 67: "ParisBlue", 68: "Violet", 69: "White", 70: "Black", 71: "Filled"
    ]
    let colorMap: [String: Color] = [
        "PoppyRed": Color.red,
        "Orange": Color.orange,
        "Yellow": Color.yellow,
        "Green": Color.green,
        "ParisBlue": Color.blue,
        "Violet": Color.purple,
        "White": Color.white,
        "Black": Color.black,
        "Filled": Color.primary
    ]
    public func assignUnique(values: [Int]) -> [Unique] {
        let uniques = values.map({Unique(value: $0)})
        return uniques
    }
    
    public struct Unique: Identifiable {
        let value: Int
        let id = UUID()
    }
    
    public func getMessage(apiKey: APIKey) async -> [Int]? {
        let endpoint = "https://rw.vestaboard.com/"
        guard let url = URL(string: endpoint) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json", 
            "X-Vestaboard-Read-Write-Key": apiKey.key,
        ]
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NSError(domain: "Invalid response", code: 2, userInfo: nil)
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let currentMessage = json["currentMessage"] as? [String: Any],
                   let layoutString = currentMessage["layout"] as? String,
                   let layoutData = layoutString.data(using: .utf8),
                   let layoutArray = try JSONSerialization.jsonObject(with: layoutData, options: []) as? [[Int]] {
                    let flatArray = layoutArray.flatMap { $0 }
                    return flatArray
                } else {
                    throw NSError(domain: "Invalid JSON structure", code: 3, userInfo: nil)
                }
            } catch {
                throw error
            }
        } catch {
            print("Error in fetching data")
            return nil
        }
    }
    
    init() {}
}
