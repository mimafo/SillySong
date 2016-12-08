//
//  ViewController.swift
//  SillySong
//
//  Created by Michael Folcher on 12/5/16.
//  Copyright © 2016 Mimafo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    //MARK: Constants
    let fullNameToken = "<FULL_NAME>"
    let shortNameToken = "<SHORT_NAME>"
    let vowelChars = CharacterSet(charactersIn: "aeiou")
    
    //MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Action methods
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    @IBAction func displayLyrics(_ sender: Any) {
        if let name = nameField.text {
            
            if !name.isEmpty {
                let bananaFanaTemplate = [
                    "\(fullNameToken), \(fullNameToken), Bo B\(shortNameToken)",
                    "Banana Fana Fo F\(shortNameToken)",
                    "Me My Mo M\(shortNameToken)",
                    "\(fullNameToken)"].joined(separator: "\n")
            
                lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
            }
        
        }
    }
    
    //MARK: Internal private methods
    func shortNameFromName(_ name: String) -> String {
        var mutableName = name.lowercased();
        
        let startingPosition = mutableName.rangeOfCharacter(from: vowelChars)
        if (startingPosition?.lowerBound) != nil {
            mutableName = mutableName.substring(from: startingPosition!.lowerBound)
        }
        return mutableName
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        
        let shortName = shortNameFromName(fullName)
        var mutableLyrics = lyricsTemplate
        
        mutableLyrics = mutableLyrics
            .replacingOccurrences(of: fullNameToken, with: fullName)
            .replacingOccurrences(of: shortNameToken, with: shortName)
        return mutableLyrics
    }

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

