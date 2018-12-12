//
//  AchievedScoreViewController.swift
//  Trivia
//
//  Created by Noud on 12/11/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class AchievedScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var buttonPostScore: UIButton!
    
    var achievedScore: Int!
    var category: String!
    var highScoreController = HighScoreController()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        scoreLabel.text = String(achievedScore)
        categoryLabel.text = category
    }
    
    @IBAction func postScore(_ sender: Any) {
        highScoreController.postHighScores(name: nameField.text!, score: achievedScore)
        buttonPostScore.isEnabled = false
    }
}
