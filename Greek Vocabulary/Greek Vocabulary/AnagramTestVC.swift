//
//  AnagramTestVC.swift
//  Greek Vocabulary
//
//  Created by pak29.
//
//  Version 1.0
//
//  This class manages the UI View Controller of the Anagram Test. It is responsible for creating the anagram, presenting it to the user, acquiring their answer and comparing it to the correct form of the anagram.
//  It creates the anagram by converting the value(Greek) string into an array of single letter strings. It then shuffles that array to create an anagram of that word. Then it converts that anagram back into a string and presents it to the user as a label.
//  Additionally, it allows the user to try the exercise again and places the words they solved correctly into a Array. The array is called when creating a new anagram as to no allow successive uses of the same words as anagrams.
//

import UIKit

class AnagramTestVC: UIViewController {
    
    var successiveCorrects: Int = 0
    var randomWord: Dictionary<String, String>.Element? = nil
    var solvedArray = [String]()
    
    @IBOutlet weak var anagramLabel: UILabel!
    
    @IBOutlet weak var translationTextField: UITextField!
    
    @IBAction func doneButton(_ sender: Any) {
        if(translationTextField.text?.capitalized == randomWord?.value){
            solvedArray.append(randomWord!.value)
            correctAnswer()
        } else {
            wrongAnswer()
        }
    }
    
    @IBAction func instructions(_ sender: Any) {
        let alertController = UIAlertController(title: "Instuctions", message: "Solve the anagram of the Greek word at the top and write on the bottom! Solve anagrams in succession to gain points!", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupView(){
        let answer = getAnswer()
        let anagram = getAnagram(randomValue: answer)
        anagramLabel.text = anagram
    }
    
    func getAnswer() -> String{
        randomWord = wordDict.randomElement()!
        for value in solvedArray{
            if (value == randomWord?.value){
                randomWord = wordDict.randomElement()!
                continue
            }
        }
        return randomWord!.value
    }
    
    func getAnagram(randomValue: String) -> String{
        var wordArray = randomValue.map {
            String($0)
        }
        wordArray.shuffle()
        let anagram = wordArray.joined(separator: "")
        return anagram.lowercased()
    }
    
    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
    }
    
    func correctAnswer(){
        successiveCorrects += 1
        let alertController = UIAlertController(title: "Good Job!", message: "You solved the anagram. Your score is: \(successiveCorrects). Would you like to go again?", preferredStyle: .alert)
        
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
        let alertController = UIAlertController(title: "Oops!", message: "You chose the wrong answer. Your final score was: \(successiveCorrects). Would you like to try again?", preferredStyle: .alert)
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
        translationTextField.text = ""
        viewDidLoad()
    }
    
    func moveToPreviousView(){
        self.navigationController?.popViewController(animated: true)
    }
}
