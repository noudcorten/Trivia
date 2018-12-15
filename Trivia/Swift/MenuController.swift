//
//  MenuController.swift
//  Trivia
//
//  Created by Noud on 12/9/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation

class MenuController {
    var baseURL: URL
    
    // MARK: creates the url for the selected category
    init (category: String) {
        let url = "https://opentdb.com/api.php?amount=10&category=" + category + "&type=multiple"
        baseURL = URL(string: url)!
    }
    
    // MARK: retrieves the questions from the internet and orders them in a struct
    func fetchQuestions(completion: @escaping ([Question]?) -> Void) {
        let request = URLRequest(url: baseURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var question_array: [Question] = []
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let results = json["results"] as? [[String: Any]] {
                            for question in results {
                                if let questionObject = Question(json: question) {
                                    question_array.append(questionObject)
                                }
                            }
                        }
                    }
                } catch {
                    completion(nil)
                }
                completion(question_array)
            }
        }
        
        task.resume()
    }
}





