//
//  HighScoreController.swift
//  Trivia
//
//  Created by Noud on 12/9/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation

class HighScoreController {
    // MARK: used for observers
    static let scoreUpdatedNotification = Notification.Name("HighScoreController.scoreUpdated")
    
    // MARK: sends give name and score to the server
    func postHighScores(name: String, score: Int) {
        let url = URL(string: "https://ide50-noud-native-app.cs50.io:8080/highscores")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=" + name + "&score=" + String(score)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    // MARK: fetches the scores on the server
    func fetchScores(completion: @escaping ([[String: Any]]?) -> Void) {
        let baseURL = URL(string: "https://ide50-noud-native-app.cs50.io:8080/highscores")!
        let request = URLRequest(url: baseURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                var scoreList: [[String: Any]] = []
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                        for dict in json {
                            scoreList.append(dict)
                        }
                    }
                } catch {
                    completion(nil)
                }
                completion(scoreList)
            }
        }
        task.resume()
    }
}
