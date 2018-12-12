//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Noud on 12/8/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {
    
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var buttonNextQuestion: UIButton!
    
    var menuController: MenuController!
    var currentGame: CurrentGame!
    var questionArray: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiate_menu()
        sleep(2)
        updateUI()
    }
    
    func initiate_menu() {
        menuController.fetchQuestions { (questions:[Question]?) in
            if let questions = questions {
                for question in questions {
                    self.questionArray.append(question)
                }
            }
        }
    }
    
    func updateUI() {
        refreshButtonsAndLabels()
        
        labelAmount.text = "Question " + String(currentGame.currentQuestion) + " (" + String(currentGame.currentQuestion) + "/10)"
        labelQuestion.text = questionArray[currentGame.currentQuestion-1].question
        
        let answer_list = make_answer_list()
        let shuffledList = currentGame.shuffleList(list: answer_list)
        updateLabels(list: shuffledList)
    }
    
    func make_answer_list() -> [String] {
        var list: [String] = []
        list.append(questionArray[currentGame.currentQuestion-1].correct_answer)
        for answer in questionArray[currentGame.currentQuestion-1].incorrect_answers {
            list.append(answer)
        }
        return list
    }
    
    func refreshButtonsAndLabels() {
        buttonNextQuestion.isHidden = true
        
        labelA.textColor = UIColor.black
        labelB.textColor = UIColor.black
        labelC.textColor = UIColor.black
        labelD.textColor = UIColor.black
        
        buttonA.isEnabled = true
        buttonB.isEnabled = true
        buttonC.isEnabled = true
        buttonD.isEnabled = true
    }
    
    func updateLabels(list: [String]) {
        labelA.text = list[0]
        labelB.text = list[1]
        labelC.text = list[2]
        labelD.text = list[3]
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case buttonA:
            if currentGame.correctAnswerIndex == 0 {
                currentGame.correcetAnswerAmount += 1
            }
            setLabelColorsAndButtons()
        case buttonB:
            if currentGame.correctAnswerIndex == 1 {
                currentGame.correcetAnswerAmount += 1
            }
            setLabelColorsAndButtons()
        case buttonC:
            if currentGame.correctAnswerIndex == 2 {
                currentGame.correcetAnswerAmount += 1
            }
            setLabelColorsAndButtons()
        case buttonD:
            if currentGame.correctAnswerIndex == 3 {
                currentGame.correcetAnswerAmount += 1
            }
            setLabelColorsAndButtons()
        case buttonNextQuestion:
            if currentGame.gameIsDone() == true {
                performSegue(withIdentifier: "ResultsSegue", sender: nil)
            } else {
                currentGame.update()
                updateUI()
            }
        default:
            return
        }
    }
    
    func setLabelColorsAndButtons() {
        buttonNextQuestion.isHidden = false
        buttonA.isEnabled = false
        buttonB.isEnabled = false
        buttonC.isEnabled = false
        buttonD.isEnabled = false
        
        let correctAnswerIndex = currentGame.correctAnswerIndex
        var labels: [UILabel] = [labelA, labelB, labelC, labelD]
        let correct_label = labels[correctAnswerIndex]
        
        correct_label.textColor = UIColor.green
        labels.remove(at: correctAnswerIndex)
        for label in labels {
            label.textColor = UIColor.red
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let achievedScoreViewController = segue.destination as! AchievedScoreViewController
            achievedScoreViewController.achievedScore = currentGame.correcetAnswerAmount
            achievedScoreViewController.category = currentGame.category
        }
    }

}
