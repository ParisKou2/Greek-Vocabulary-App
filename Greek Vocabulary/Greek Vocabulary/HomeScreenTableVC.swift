//
//  HomeScreenTableVC.swift
//  Greek Vocabulary
//
//  Created by pak29.
//
//  Version 1.0
//
//  This is the UITable View Controller for the Home Screen, the first screen that appears when opening the app.
//  Creates 1 section with 3 rows.
//  Utilizes loadFromFile to load information from a file which is stored localy on the device.

import UIKit

class HomeScreenTableVC: UITableViewController {
    
    override func viewDidLoad() {
        loadFromFile()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
