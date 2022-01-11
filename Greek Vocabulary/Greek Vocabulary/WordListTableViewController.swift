//
//  WordListTableViewController.swift
//  Greek Vocabulary
//
//  Created by pak29.
//
//  Version 1.0
//
//  This class serves as the UI Table View Controller for the list of words screen. It starts by loading the the dictionary with all the words. Using that dictionary, it creates a single section and as many rows as elements in the dictionary. It then iterates through the table using an index and places the English keys and Greek values in every cell, showing the English ones on the left and the Greek ones on the right.
//

import UIKit

class WordListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        loadFromFile()
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordDict.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordCell
        
        let index = wordDict.index(wordDict.startIndex, offsetBy: indexPath.row)
        
        cell.textLabel?.text = (wordDict.keys[index])
        cell.detailTextLabel?.text = (wordDict.values[index])
        
        return cell
    }
}


