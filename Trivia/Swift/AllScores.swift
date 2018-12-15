//
//  AllScores.swift
//  Trivia
//
//  Created by Noud on 12/15/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation

// MARK: used to store all the scores available on the server
struct AllScores: Codable {
    var scoreItems: [Score]
    
    init(scoreItems: [Score] = []) {
        self.scoreItems = scoreItems
    }
    
    mutating func sortScores() {
        self.scoreItems = self.scoreItems.sorted(by: { $0.score > $1.score })
    }
}

