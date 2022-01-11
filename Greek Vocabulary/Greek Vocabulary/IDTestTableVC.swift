//
//  IDTestTableVC.swift
//  Greek Vocabulary
//
//  Created by pak29.
//
//  Version 1.0
//
//  This class serves as the UI Table View Controller for the identification test. It performs a multitude of checks to make sure the table is filled out with unique words, and with words that have not been answered in the same session.
//  It starts by randomly getting a Key - Value combination from the word dictionary. It continues by checking that the combination has not already been queued to be inputed in the table. Next, it iterates through a dictionary of words that have already been used in the ID test and checks if the combination is in that dictionary. If it passes both of these tests, the Key - Value combination is added to a new dictionary.
//  Once four combinations have been added to the new dictionary, it chooses one randomly and that is the assigned "answer". It take its key(English) and places it in the label to be identified by the user, and saves its value(Greek). Finally, it creates the cells in the table using the the new dictionary.
//  Once the user selects a cell and clicks the "Select" button on the top right, it iterates through all four of the cells and checks which one was selected. If the one that's selected contains the correct translation to the English word in the label, it alerts the user that they have been succesful and prompts them to try again or exit the test.
//

import UIKit

class IDTestTableVC: UITableViewController {
    
    var successiveCorrects: Int = 0
    var currentDict = [String: String]()
    var currentAnswer : Dictionary<String, String>.Element? = nil
    var answeredDict = [String: String]()
    
    @IBOutlet weak var questionWord: UILabel!
    
    @IBAction func instruction(_ sender: Any) {
        let alertController = UIAlertController(title: "Instructions", message: "An English word is shown at the top, select it's Greek translation from the list to win!", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func trySelected(_ sender: Any) {
        let cells = self.tableView.visibleCells
        for cell in cells{
            if cell.isSelected{
                if cell.textLabel?.text == currentAnswer?.value{
                    successiveCorrects += 1
                    let alertController = UIAlertController(title: "Nice Job!", message:"You identified the correct translation. You've been correct \(successiveCorrects) time(s) in a row. Would you like to go again?", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
                        action in
                        self.moveToPreviousView()
                    }))
                    alertController.addAction(UIAlertAction(title:"Go Again", style: .default, handler: {
                        action in
                        self.addAnsweredToDict()
                        self.refreshView()
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Oops!", message: "You identified the wrong translation. Your score was: \(successiveCorrects) Would you like to try again?", preferredStyle: .alert)
                    successiveCorrects = 0
                    answeredDict.removeAll()
                    
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
                        action in self.moveToPreviousView()
                    }))
                    alertController.addAction(UIAlertAction(title:"Try Again", style: .default, handler: {
                        action in self.refreshView()
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func addAnsweredToDict(){
        let key = currentAnswer!.key
        let value = currentAnswer!.value
        answeredDict[key] = value
    }
    
    func refreshView(){
        viewDidLoad()
        tableView.reloadData()
    }
    
    func moveToPreviousView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getRandoms() -> Dictionary<String,String> {
        var randomDict = [String: String]()
        outerloop: while (randomDict.count < 4) {
            var randomWord = wordDict.randomElement()!
            
            if (randomDict[randomWord.key] != nil) {
                randomWord = wordDict.randomElement()!
                continue outerloop
            }
            innerloop: for (key, _) in answeredDict {
                if(key == randomWord.key){
                    randomWord = wordDict.randomElement()!
                    continue outerloop
                }
            }
            randomDict[randomWord.key] = randomWord.value
        }
        return randomDict
    }
    func getAnswer(randDict: Dictionary<String, String>) -> Dictionary<String, String>.Element{
        
        let answer = randDict.randomElement()!
        return answer
    }
    
    func setNewDict(){
        currentDict = getRandoms()
        currentAnswer = getAnswer(randDict: currentDict)
        
        questionWord.text = currentAnswer?.key
    }
    
    override func viewDidLoad() {
        setNewDict()
        super.viewDidLoad()
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDict.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RandomCell", for: indexPath) as! RandomCell
        
        let index = currentDict.index(currentDict.startIndex, offsetBy: indexPath.row)
        
        cell.textLabel?.text = (currentDict.values[index])
        
        return cell
    }
    
}
