//
//  AddNewVC.swift
//  Greek Vocabulary
//
//  Created by pak29.
//
//  Version 1.0
//
//  This class manages the addition of new words to the dictionary. It also serves as the UI View Controller of the equivalent View.
//  The class performs an order of checks on the users input. Checks such as, if the word has been added before, if the users input is in English and Greek according to the appropriate text fields, and it checks if the fields are empty. If all checks are passed, it adds the words to the dictionary and saves the dictionary to a file.
//  The class also presents an alert to the user to notify them if the word was added to the dictionary or if there was a problem while trying to add it.
//  Imports the Natural Language framework to properly recognize the language that the user writes in.
//

import UIKit
import NaturalLanguage

class AddNewVC: UIViewController {
    
    @IBOutlet weak var englishWord: UITextField!
    @IBOutlet weak var greekWord: UITextField!
    
    @IBAction func addNew(_ sender: Any) {
        let english = englishWord.text?.capitalized ?? ""
        let greek = greekWord.text?.capitalized ?? ""
        
        let original = checkLanguage(textWriten: english) ?? "Error"
        let translation = checkLanguage(textWriten: greek) ?? "Error"
        
        if (checkTextFields(orig: original, transl: translation)) == true {
            findIfExists(eng: english, gre: greek)
        } else {
            let alertController = UIAlertController(title: "Error", message:
                                                        "One of the text fields is empty or a wrong language was used. Please only write in English and in Greek in the appropriate text fields.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action in
                self.clearTextFields()
                
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func findIfExists(eng: String, gre: String) {
        if  (wordDict[eng] == nil) {
            wordDict[eng] = gre
            confirmAlert()
            saveToFile()
        } else {
            discardAlert()
        }
    }
    func checkTextFields(orig: String, transl: String) -> Bool?{
        var isOriginal = false
        var isTranslated = false
        if (orig == "English"){
            isOriginal = true
        }
        if (transl == "Greek"){
            isTranslated = true
        }
        if ((isOriginal && isTranslated) == true){
            return true
        } else {
            return false
        }
    }
    func checkLanguage(textWriten: String) -> String? {
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(textWriten)
        guard let languageCode = languageRecognizer.dominantLanguage?.rawValue else {
            return nil
        }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLanguage
    }
    
    func clearTextFields(){
        englishWord.text = ""
        greekWord.text = ""
    }
    
    func confirmAlert(){
        let alertController = UIAlertController(title: "Success!", message: "Word succesfully added to the dictionary!", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
            action in
            self.clearTextFields()
        }))
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    func discardAlert(){
        let alertController = UIAlertController(title: "Error", message: "Word already exists in the dictionary and was not added.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
            action in
            self.clearTextFields()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
