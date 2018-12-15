//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Noud on 12/8/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {
    
    // MARK: properies
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
    
    func updateUI() {
        DispatchQueue.main.async {
            self.hideInterface(bool: false)
            self.refreshButtonsAndLabels()
            self.labelPoints.text = "Points: " +  String(self.currentGame.correcetAnswerAmount)
        
            self.labelAmount.text = "Question " + String(self.currentGame.currentQuestion) + " (" + String(self.currentGame.currentQuestion) + "/10)"
            self.labelQuestion.text = self.questionArray[self.currentGame.currentQuestion-1].question
        
            let answer_list = self.make_answer_list()
            let shuffledList = self.currentGame.shuffleList(list: answer_list)
            self.updateLabels(list: shuffledList)
        }
    }
    
    // MARK: hides interface when loading questions, and shows interface when loading is done
    func hideInterface(bool: Bool) {
        DispatchQueue.main.async {
            self.labelAmount.isHidden = bool
            self.labelQuestion.isHidden = bool
            self.buttonA.isHidden = bool
            self.buttonB.isHidden = bool
            self.buttonC.isHidden = bool
            self.buttonD.isHidden = bool
            self.labelA.isHidden = bool
            self.labelB.isHidden = bool
            self.labelC.isHidden = bool
            self.labelD.isHidden = bool
            self.buttonNextQuestion.isHidden = bool
            self.labelPoints.isHidden = bool
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
    
    // MARK: resets the answer labels colors and the answer buttons
    func refreshButtonsAndLabels() {
        buttonNextQuestion.isHidden = true
        
        labelA.textColor = UIColor.black
        labelB.textColor = UIColor.black
        labelC.textColor = UIColor.black
        labelD.textColor = UIColor.black
        
        hideButtons(bool: true)

    }
    
    // MARK: hides or shows the answer buttons
    func hideButtons(bool: Bool) {
        buttonA.isEnabled = bool
        buttonB.isEnabled = bool
        buttonC.isEnabled = bool
        buttonD.isEnabled = bool
    }
    
    // MARK: sets every answer label with an answer from the shuffled list
    func updateLabels(list: [String]) {
        labelA.text = list[0]
        labelB.text = list[1]
        labelC.text = list[2]
        labelD.text = list[3]
    }
    
    // MARK: function which reacts on a button press. Possible buttons are:
    // - Answers buttons (A,B,C,D)
    //  => checks if answer is correct and shows which was the right and wrong answers
    // - Next question button
    //  => checks if the quiz is done (go to result screen, else: go to next question)
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case buttonA:
            if currentGame.correctAnswerIndex == 0 {
                currentGame.correcetAnswerAmount += 10
            }
            setLabelColorsAndButtons()
        case buttonB:
            if currentGame.correctAnswerIndex == 1 {
                currentGame.correcetAnswerAmount += 10
            }
            setLabelColorsAndButtons()
        case buttonC:
            if currentGame.correctAnswerIndex == 2 {
                currentGame.correcetAnswerAmount += 10
            }
            setLabelColorsAndButtons()
        case buttonD:
            if currentGame.correctAnswerIndex == 3 {
                currentGame.correcetAnswerAmount += 10
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
