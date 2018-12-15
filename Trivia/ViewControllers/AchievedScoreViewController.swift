//
//  AchievedScoreViewController.swift
//  Trivia
//
//  Created by Noud on 12/11/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class AchievedScoreViewController: UIViewController {
    
    // MARK: properties
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var buttonPostScore: UIButton!
    
    var achievedScore: Int!
    var category: String!
    var highScoreController = HighScoreController()

    // MARK: sets the category label and score label according to their value
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        scoreLabel.text = String(achievedScore)
        categoryLabel.text = category
    }
    
    // MARK: sends the score of the user to the server
    @IBAction func postScore(_ sender: Any) {
        buttonPostScore.isEnabled = false
        highScoreController.postHighScores(name: nameField.text!, score: achievedScore)
        
        UIView.animate(withDuration: 0.3) {
        self.buttonPostScore.transform =
            CGAffineTransform(scaleX: 3.0, y: 3.0)
        self.buttonPostScore.transform =
            CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        NotificationCenter.default.post(name:
            HighScoreController.scoreUpdatedNotification, object: nil)
        
    }
}
