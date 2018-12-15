//
//  TableViewCell.swift
//  Trivia
//
//  Created by Noud on 12/14/18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
