//
//  Question.swift
//  Trivia
//
//  Created by Noud on 12/9/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation
import HTMLString

// MARK: stores all the available data of the current question
struct Question: Codable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    
    struct PropertyKeys {
        static let category = "category"
        static let type = "type"
        static let difficulty = "difficulty"
        static let question = "question"
        static let correct_answer = "correct_answer"
        static let incorrect_answers = "incorrect_answers"
    }
    
    init?(json: [String: Any]) {
        guard
            let category = json[PropertyKeys.category] as? String,
            let type = json[PropertyKeys.type] as? String,
            let difficulty = json[PropertyKeys.difficulty] as? String,
            let question = json[PropertyKeys.question] as? String,
            let correct_answer = json[PropertyKeys.correct_answer] as? String,
            let incorrect_answers = json[PropertyKeys.incorrect_answers] as? [String]
        else { return nil }
        
        self.category = category
        self.type = type
        self.difficulty = difficulty
        self.question = question.removingHTMLEntities
        self.correct_answer = correct_answer.removingHTMLEntities
        
        var incorrect_answer_list: [String] = []
        for incorrect_answer in incorrect_answers {
            incorrect_answer_list.append(incorrect_answer.removingHTMLEntities)
        }
        self.incorrect_answers = incorrect_answer_list
    }
}

