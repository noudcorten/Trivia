//
//  Score.swift
//  Trivia
//
//  Created by Noud on 12/12/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation

struct Score {
    let id: Int
    let name: String
    let score: String
    
    struct PropertyKeys {
        static let id = "id"
        static let name = "name"
        static let score = "score"
    }
    
    init?(dict: [String: Any]) {
        guard
            let id = dict[PropertyKeys.id] as? Int,
            let name = dict[PropertyKeys.name] as? String,
            let score = dict[PropertyKeys.score] as? String
            else { return nil }
        
        self.id = id
        self.name = name
        self.score = score
    }
}
