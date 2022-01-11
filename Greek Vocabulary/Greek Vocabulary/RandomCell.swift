//
//  RandomCell.swift
//  Greek Vocabulary
//
//  Created by pak29.
//
//  Version 1.0
//
//  This class manages the UI Table View Cells used in the ID Test. It creates an IBOutlet of a randomWordLabel used to fill the table with randomly selected words.
//

import UIKit

class RandomCell: UITableViewCell {
    
    @IBOutlet weak var randomWordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
