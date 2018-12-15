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
    var highScoreList: [Score] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        getHighScore()
        sleep(1)
        updateUI()
    }
    
    func getHighScore(){
        highScoreController.fetchQuestions { (highScores:[[String: Any]]?) in
            if let highScores = highScores {
                for score in highScores {
                    if let scoreObject = Score(dict: score) {
                        self.highScoreList.append(scoreObject)
                    }
                }
            }
        }
    }
    
    func updateUI() {
        for scoreObject in highScoreList {
            if Int(scoreObject.score)! >= highestScore {
                highestScore = Int(scoreObject.score)!
                highestScoreName = scoreObject.name
            }
        }
        labelScore.text = String(highestScore)
        labelName.text = highestScoreName
    }
}
