//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Noud on 12/8/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {
    
    // MARK: properties
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
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var labelDifficulty: UILabel!
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var allButtons: [UIButton]!
    
    var menuController: MenuController!
    var currentGame: CurrentGame!
    var questionArray: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideInterface(bool: true)
        initiate_menu()
    }
    
    // MARK: fetches the questions from the API and updates the UI if this is done
    func initiate_menu() {
        menuController.fetchQuestions { (questions:[Question]?) in
            if let questions = questions {
                for question in questions {
                    self.questionArray.append(question)
                }
            }
            self.updateUI()
        }
    }
    
    // MARK: updates the UI which consisits of:
    // - Updating the question
    // - Updating question index
    // - Updating the possible answers
    // - Updating the difficulty label
    
    func updateUI() {
        DispatchQueue.main.async {
            self.hideInterface(bool: false)
            self.refreshButtonsAndLabels()
            self.labelPoints.text = "Points: " +  String(self.currentGame.correcetAnswerAmount)
        
            self.labelAmount.text = "Question " + String(self.currentGame.currentQuestion) + " (" + String(self.currentGame.currentQuestion) + "/10)"
            self.labelQuestion.text = self.questionArray[self.currentGame.currentQuestion-1].question
            self.setDifficulty(setColor: true, givePoints: false)
        
            let answer_list = self.make_answer_list()
            let shuffledList = self.currentGame.shuffleList(list: answer_list)
            self.updateLabels(list: shuffledList)
        }
    }
    
    // MARK: hides interface when loading questions, and shows interface when loading is done
    func hideInterface(bool: Bool) {
        DispatchQueue.main.async {
            for label in self.allLabels {
                label.isHidden = bool
            }
            for button in self.allButtons {
                button.isHidden = bool
            }
        }
    }
    
    // MARK: function which sets the difficulty label or sets the right amount of points
    func setDifficulty(setColor: Bool, givePoints: Bool) {
        let difficulty = self.questionArray[self.currentGame.currentQuestion-1].difficulty
        labelDifficulty.text = difficulty.uppercased()
        
        switch difficulty {
        case "easy":
            if setColor == true {
                labelDifficulty.textColor = UIColor.green
                print("test")
            }
            if givePoints == true {
                currentGame.correcetAnswerAmount += 10
            }
        case "medium":
            if setColor == true {
                labelDifficulty.textColor = UIColor.orange
            }
            if givePoints == true {
                currentGame.correcetAnswerAmount += 20
            }
        case "hard":
            if setColor == true {
                labelDifficulty.textColor = UIColor.red
            }
            if givePoints == true {
                currentGame.correcetAnswerAmount += 30
                }
        default:
            return
        }
    }
    
    // MARK: function which makes a list with all the possible answers
    func make_answer_list() -> [String] {
        var list: [String] = []
        list.append(questionArray[currentGame.currentQuestion-1].correct_answer)
        for answer in questionArray[currentGame.currentQuestion-1].incorrect_answers {
            list.append(answer)
        }
        return list
    }
    
    // MARK: resets all the label colors (except category label) and the shows the answer buttons
    func refreshButtonsAndLabels() {
        buttonNextQuestion.isHidden = true
        DispatchQueue.main.async {
            for label in self.allLabels {
                if label == self.labelDifficulty {
                    continue
                }
                label.textColor = UIColor.black
            }
        }
        
        hideButtons(bool: true)
    }
    
    // MARK: hides or shows the answer buttons
    func hideButtons(bool: Bool) {
        DispatchQueue.main.async {
            self.buttonA.isEnabled = bool
            self.buttonB.isEnabled = bool
            self.buttonC.isEnabled = bool
            self.buttonD.isEnabled = bool
        }
    }
    
    // MARK: sets every answer label with an answer from the shuffled list
    func updateLabels(list: [String]) {
        DispatchQueue.main.async {
            self.labelA.text = list[0]
            self.labelB.text = list[1]
            self.labelC.text = list[2]
            self.labelD.text = list[3]
        }
    }
    
    // MARK: function which reacts on a button press. Possible buttons are:
    // - Answers buttons (A,B,C,D)
    //  => checks if answer is correct and shows which was the right and wrong answers
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case buttonA:
            if currentGame.correctAnswerIndex == 0 {
                setDifficulty(setColor: false, givePoints: true)
            }
        case buttonB:
            if currentGame.correctAnswerIndex == 1 {
                setDifficulty(setColor: false, givePoints: true)
            }
        case buttonC:
            if currentGame.correctAnswerIndex == 2 {
                setDifficulty(setColor: false, givePoints: true)
            }
        case buttonD:
            if currentGame.correctAnswerIndex == 3 {
                setDifficulty(setColor: false, givePoints: true)
            }
        default:
            return
        }
        setLabelColorsAndButtons()
    }
    
    // MARK: checks if the quiz is done (yes: go to result screen, no: go to next question)
    @IBAction func nextQuestion(_ sender: Any) {
        if currentGame.gameIsDone() == true {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        } else {
            currentGame.update()
            updateUI()
        }
    }
    
    // MARK: updates the points label, hides the answer buttons and sets the color of the answer label according to their status (wrong: red, right: green)
    func setLabelColorsAndButtons() {
        labelPoints.text = "Points: " +  String(currentGame.correcetAnswerAmount)
        buttonNextQuestion.isHidden = false
        hideButtons(bool: false)
        
        let correctAnswerIndex = currentGame.correctAnswerIndex
        var labels: [UILabel] = [labelA, labelB, labelC, labelD]
        let correct_label = labels[correctAnswerIndex]
        
        correct_label.textColor = UIColor.green
        labels.remove(at: correctAnswerIndex)
        for label in labels {
            label.textColor = UIColor.red
        }
    }
    
    // MARK: prepares for results segue if quiz is done by giving the result screen the chosen category and achieved score
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let achievedScoreViewController = segue.destination as! AchievedScoreViewController
            achievedScoreViewController.achievedScore = currentGame.correcetAnswerAmount
            achievedScoreViewController.category = currentGame.category
        }
    }

}
