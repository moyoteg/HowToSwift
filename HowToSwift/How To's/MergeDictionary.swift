//
//  MergeDictionary.swift
//  HowToSwift
//
//  Created by Moi Gutierrez on 9/24/21.
//

import SwiftUI

struct MergeDictionary: View {
    
    enum Value: String, Codable {
        case one
        case two
        case three
    }
    
    @State var dictionary: [Value:[String]] = [
        .one: ["❌"],
        .two: ["❌"],
        .three: ["❌"],
    ]
    
    var jsonString: String {
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(dictionary),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return "could not convert dictionary to JSON 🤔"
        }
        return jsonString
    }
    
    var body: some View {
        VStack {
            Text("\(jsonString)")
            
            Button("merge dictionary") {
                let newDict: [Value:[String]] = [
                    .one: ["✅"],
                ]
                
                dictionary.merge(newDict) { old, new in
                    return new
                }
                
            }
            .padding()
            
            Button("reset dictionary") {
                
                dictionary = [
                    .one: ["❌"],
                    .two: ["❌"],
                    .three: ["❌"],
                ]
            }
            .padding()
        }
    }
}

struct MergeDictionary_Previews: PreviewProvider {
    static var previews: some View {
        MergeDictionary()
    }
}
