//
//  HighScoresTableViewController.swift
//  Trivia
//
//  Created by Noud on 12/8/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class HighScoresTableViewController: UIViewController {
    
    
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    
    let highScoreController = HighScoreController()
    var highestScore: Int = 0
    var highestScoreName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let highScoreList = getHighScoreList()
        getHighScore(list: highScoreList)
        labelScore.text = String(highestScore)
        labelName.text = highestScoreName
    }
    
    func getHighScoreList() -> [Score] {
        var scoreList: [Score] = []
        highScoreController.fetchQuestions { (highScores:[[String: Any]]?) in
            if let highScores = highScores {
                sleep(2)
                for score in highScores {
                    if let scoreObject = Score(dict: score) {
                        scoreList.append(scoreObject)
                    }
                }
            }
        }
        sleep(3)
        return scoreList
    }
    
    func getHighScore(list: [Score]){
        for scoreObject in list {
            if Int(scoreObject.score)! >= highestScore {
                highestScore = Int(scoreObject.score)!
                highestScoreName = scoreObject.name
            }
        }
    }

}
