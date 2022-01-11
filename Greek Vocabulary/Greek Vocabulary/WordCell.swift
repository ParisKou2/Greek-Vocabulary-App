//
//  WordCell.swift
//  Greek Vocabulary
//
//  Created by pak29.
//
//  Version 1.0
//
//  This class manages the UI Table View Cells of the Words used in the Word List table. It simply implements two IBOutlets used to fill out the table.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet weak var originalWord: UILabel!
    @IBOutlet weak var translatedWord: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
