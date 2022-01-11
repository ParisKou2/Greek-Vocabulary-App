//
//  SpellingTestVC.swift
//  Greek Vocabulary
//
//  Created by pak29.
//
//  Version 1.0
//
//  This class is responsible for the UI View Controller of the spelling test. The spelling test chooses a random combination of Key-Value from the dictionary and presents its key(English) to the user. It follows by taking a value(Greek) input from a text field and compares that to the value of the aforementioned Key-Value combination and comparing it's value to the user's answer.
//  If the answer is anything but the correct translation of the English word, it presents a unsuccesful attempt alert to the user.
//

import UIKit

class SpellingTestVC: UIViewController {
    
    var successiveCorrects = 0
    var randomWord: Dictionary<String, String>.Element? = nil
    var solvedArray = [String]()
    
    @IBOutlet weak var englishLabel: UILabel!
    
    @IBOutlet weak var greekTextField: UITextField!
    
    @IBAction func doneButton(_ sender: Any) {
        if (greekTextField.text?.capitalized == randomWord?.value){
            solvedArray.append(randomWord!.key)
            correctAnswer()
        }else{
            wrongAnswer()
        }
    }
    
    @IBAction func instructions(_ sender: Any) {
        let alertController = UIAlertController(title: "Instuctions", message: "Translate the English word in the top and spell in it in the bottom field. Spell words correctly in succession to gain points!", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)

    }
    
    func setupLabel(){
        let randomEnglish = getRandomWord()
        englishLabel.text = randomEnglish
    }
    
    func getRandomWord() -> String{
        randomWord = wordDict.randomElement()!
        for key in solvedArray{
            if (key == randomWord?.key){
                randomWord = wordDict.randomElement()!
                continue
            }
        }
        return randomWord!.key
    }
    override func viewDidLoad() {
        setupLabel()
        super.viewDidLoad()
    }
    
    func correctAnswer(){
        successiveCorrects += 1
        let alertController = UIAlertController(title: "Great Job!", message: "You spelled the word correctly! Your score is: \(successiveCorrects). Would you like to go again?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
            action in self.moveToPreviousView()
        }))
        alertController.addAction(UIAlertAction(title:"Go Again", style: .default, handler: {
            action in
            self.refreshView()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func wrongAnswer(){
        let alertController = UIAlertController(title: "Oops!", message: "You spelled the word incorrectly. Your final score was: \(successiveCorrects). Would you like to try again?", preferredStyle: .alert)
        successiveCorrects = 0
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
            action in self.moveToPreviousView()
        }))
        alertController.addAction(UIAlertAction(title:"Try Again", style: .default, handler: {
            action in
            self.refreshView()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func refreshView(){
        greekTextField.text = ""
        viewDidLoad()
    }
    
    func moveToPreviousView(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
