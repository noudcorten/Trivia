//
//  TableViewController.swift
//  Trivia
//
//  Created by Noud on 12/15/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: properties
    var highScoreController = HighScoreController()
    var highScoreList = [Score]()
    var allScores = AllScores()
    
    // MARK: checks if a score is send to the server and updates the score list
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setHighScore()
        
        NotificationCenter.default.addObserver(tableView, selector: #selector(UITableView.reloadData), name: HighScoreController.scoreUpdatedNotification, object: nil)
        
    }
    
    // MARK: retrieves the scores from the server and adds them to the TableView in sorted order
    func setHighScore(){
        highScoreList = []
        highScoreController.fetchScores { (highScores:[[String: Any]]?) in
            if let highScores = highScores {
                for score in highScores {
                    if let scoreObject = Score(dict: score) {
                        self.highScoreList.append(scoreObject)
                    }
                }
                self.allScores.scoreItems = self.highScoreList
                self.allScores.sortScores()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: if the score list is not updated, the user can refresh the high score page
    @IBAction func refreshScores(_ sender: Any) {
        setHighScore()
    }

    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "TableViewCell"

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allScores.scoreItems.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell
            else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // MARK: sets the name- and score-label of the ViewCell accordingly
        let highScore = allScores.scoreItems[indexPath.row]
        DispatchQueue.main.async {
            cell.labelName.text = highScore.name
            cell.labelScore.text = String(highScore.score)
        }

        return cell
    }
    
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
