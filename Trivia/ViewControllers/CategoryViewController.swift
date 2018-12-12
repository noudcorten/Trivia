//
//  CategoryViewController.swift
//  Trivia
//
//  Created by Noud on 12/8/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var ButtonRandom: UIButton!
    @IBOutlet weak var ButtonScienceAndNature: UIButton!
    @IBOutlet weak var ButtonSports: UIButton!
    @IBOutlet weak var ButtonGeography: UIButton!
    @IBOutlet weak var ButtonHistory: UIButton!
    
    var category: String!
    var categoryName: String!
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        switch sender {
        case ButtonRandom:
            category = ""
            categoryName = "Random"
        case ButtonScienceAndNature:
            category = "17"
            categoryName = "Science and Nature"
        case ButtonSports:
            category = "21"
            categoryName = "Sports"
        case ButtonGeography:
            category = "22"
            categoryName = "Geography"
        case ButtonHistory:
            category = "23"
            categoryName = "History"
        default: break
        }
        performSegue(withIdentifier: "choiceSegue", sender: nil)
    }
    
    @IBAction func unwindToQuizIntroduction(segue:
    UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choiceSegue" {
            let triviaViewController = segue.destination as! TriviaViewController
            triviaViewController.menuController = MenuController(category: category)
            triviaViewController.currentGame = CurrentGame(currentQuestion: 1, correctAnswerIndex: 0, correctAnswerAmount: 0, category: categoryName)
        }
    }
}
