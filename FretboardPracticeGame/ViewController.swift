
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
    @IBOutlet weak var correctCounter: UILabel!
    @IBOutlet weak var wrongCounter: UILabel!
    @IBOutlet weak var timerView: UILabel!
    @IBOutlet weak var restartPrompt: UILabel!
    
    var startBool = true
    var buttonBool = true

    var fretboardArray: [[Int]] = [[6], [12]]
    
    var stringNumber = 0
    var fretNumber = 0
    var secondCount = 15
    var randomAnswer = ""
    var baseNote = ""
    var fretNote = ""
    var userAnswer = ""
    
    var timer: NSTimer?
    
    var BString: [String] = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    var AString: [String] = ["A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"]
    var DString: [String] = ["D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"]
    var eString: [String] = ["F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]
    var GString: [String] = ["G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"]
    
    
    @IBAction func startGame(sender: UIButton) {
        if startBool{
            answerPrompt.text! = ""
            restartPrompt.text! = ""
            getRandomAnswer()
            correctAnswerDisplay.text! = randomAnswer
            
            startTimer()
            startBool = false
            buttonBool = true
        }
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        timer!.fire()
    }
    func updateTime(){
        timerView.text! = ("\(secondCount)")
        secondCount = secondCount - 1
        if (secondCount < 0){
            endGame()
            timer!.invalidate()
            secondCount = 15
        }
    }
    
    @IBAction func noteButtonPress(sender: UIButton) {
        if buttonBool{
            var selectedAnswer = sender.titleLabel?.text
            userAnswer = selectedAnswer!
        
        
            println(fretNumber)
            println(stringNumber)
        
            checkAnswer()
            reset()
        }
        
    }
    
    func getRandomAnswer(){
        fretNumber = Int(arc4random_uniform(12))
        stringNumber = Int(arc4random_uniform(6))
        
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
    
    var score = 0
    func checkAnswer(){
        if(userAnswer == randomAnswer){
            answerPrompt.text! = "CORRECT"
            score = score + 100
            correctCounter.text! = "\(score)"
        }else{
            answerPrompt.text! = "WRONG"
            if(score == 0){
                score = 0
            }else{
                score = score - 50
            }
            correctCounter.text! = "\(score)"
        }
    }
    
    func reset(){
        //NSThread.sleepForTimeInterval(1)
        //answerPrompt.text! = ""
        getRandomAnswer()
        //NSThread.sleepForTimeInterval(0.5)
        correctAnswerDisplay.text! = randomAnswer
    }
    
    func endGame(){
        correctCounter.text! = ""
        correctAnswerDisplay.text! = ""
        answerPrompt.text! = "\(score)"
        score = 0
        //timerView.text! = ""
        restartPrompt.text! = "Touch Start to Play Again"
        startBool = true
        buttonBool = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

