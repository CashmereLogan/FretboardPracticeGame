
//  ViewController.swift
//  FretboardPracticeGame
//
//  Created by DFA Film 11: Brian on 5/4/15.
//  Copyright (c) 2015 DFA Film 11: Brian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var answerPrompt: UILabel!
    @IBOutlet weak var correctAnswerDisplay: UILabel!

    var fretboardArray: [[Int]] = [[6], [12]]
    
    var stringNumber = 0
    var fretNumber = 0
    var randomAnswer = ""
    var baseNote = ""
    var fretNote = ""
    var userAnswer = ""
    
    var BString: [String] = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    var AString: [String] = ["A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"]
    var DString: [String] = ["D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"]
    var eString: [String] = ["F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]
    var GString: [String] = ["G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"]
    
    
    @IBAction func startGame(sender: UIButton) {
        getRandomAnswer()
        correctAnswerDisplay.text! = randomAnswer
    }
    
    @IBAction func noteButtonPress(sender: UIButton) {
        
        var selectedAnswer = sender.titleLabel?.text
        userAnswer = selectedAnswer!
        
        
        println(fretNumber)
        println(stringNumber)
        
        checkAnswer()
        
    }
    
    func getRandomAnswer(){
        fretNumber = Int(arc4random_uniform(12)) + 1
        stringNumber = Int(arc4random_uniform(6)) + 1
        
        getFretNote()
        
        randomAnswer = fretNote
    }
    
    func getFretNote(){
        if(stringNumber == 1 || stringNumber == 6){
            baseNote = "e"
            fretNote = eString[fretNumber]
        }else if(stringNumber == 2){
            baseNote = "B"
            fretNote = BString[fretNumber]
        }else if(stringNumber == 3){
            baseNote = "G"
            fretNote = GString[fretNumber]
        }else if(stringNumber == 4){
            baseNote = "D"
            fretNote = DString[fretNumber]
        }else if(stringNumber == 5){
            baseNote = "A"
            fretNote = AString[fretNumber]
        }
    }
    
    func checkAnswer(){
        if(userAnswer == randomAnswer){
            answerPrompt.text! = "CORRECT"
        }else{
            answerPrompt.text! = "WRONG"
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

