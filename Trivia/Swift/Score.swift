//
//  Score.swift
//  Trivia
//
//  Created by Noud on 12/12/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation

// MARK: used to store the name and score of the retrieved ServerInput-Score in a nice way
struct Score: Codable {
    let name: String
    let score: String
    
    struct PropertyKeys {
        static let name = "name"
        static let score = "score"
    }
    
    init?(dict: [String: Any]) {
        guard
            let name = dict[PropertyKeys.name] as? String,
            let score = dict[PropertyKeys.score] as? String
            else { return nil }
        
        self.name = name
        self.score = score
    }
}
