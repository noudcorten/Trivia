//
//  CurrentGame.swift
//  Trivia
//
//  Created by Noud on 12/11/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation

// MARK: used to store all the data in the current game
struct CurrentGame {
    var currentQuestion: Int
    var correctAnswerIndex: Int
    var correcetAnswerAmount: Int
    var category: String
    
    init(currentQuestion: Int, correctAnswerIndex: Int, correctAnswerAmount: Int, category: String) {
        self.currentQuestion = currentQuestion
        self.correctAnswerIndex = correctAnswerIndex
        self.correcetAnswerAmount = correctAnswerAmount
        self.category = category
    }
    
    // MARK: tells the ViewController what is the current question index
    mutating func update() {
        self.currentQuestion += 1
    }
    
    // MARK: gets a list with all the possible answers and shuffles them into a new list but keeps track of where the right answer is in the list
    mutating func shuffleList(list: [String]) -> [String] {
        let correctAnswer = list[0]
        let shuffledSequence = list.shuffled()
        if let index = shuffledSequence.firstIndex(of: correctAnswer) {
            self.correctAnswerIndex = index
        }
        return shuffledSequence
    }
    
    // MARK: checks if the quiz is done
    func gameIsDone() -> Bool {
        if self.currentQuestion == 10 {
            return true
        }
        return false
    }
}
