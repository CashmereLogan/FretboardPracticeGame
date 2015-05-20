
//  ViewController.swift
//  FretboardPracticeGame
//
//  Created by DFA Film 11: Brian on 5/4/15.
//  Copyright (c) 2015 DFA Film 11: Brian. All rights reserved.
//

import UIKit



class timedGame: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var correctCounter: UILabel!
    @IBOutlet weak var wrongCounter: UILabel!
    @IBOutlet weak var timerView: UILabel!
    
    @IBOutlet weak var noteDot: UILabel!
    @IBOutlet weak var noteDotX: NSLayoutConstraint!
    @IBOutlet weak var noteDotY: NSLayoutConstraint!

    @IBOutlet weak var blurConstrainty: NSLayoutConstraint!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
   
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var buttonBool = false
    var pauseBool = true
    
    var fretboardArray: [[Int]] = [[6], [12]]
    
    var stringNumber = 0
    var fretNumber = 0
    var secondCount = 30
    var randomAnswer = ""
    var baseNote = ""
    var fretNote = ""
    var userAnswer = ""
    var timeAtPause = 0
    
    var stringPosition = 0
    var fretPosition = 0
    
    var timer: NSTimer?
    
    var BString: [String] = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    var AString: [String] = ["A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"]
    var DString: [String] = ["D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"]
    var eString: [String] = ["F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]
    var GString: [String] = ["G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"]
    
    
    @IBAction func startGame(sender: UIButton?) {
        correctCounter.text! = "0"
        getRandomAnswer()
            
        startTimer()
        buttonBool = true
        pauseBool = true
        pauseButton.hidden = false
        startButton.hidden = true
        noteDot.hidden = false
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
            secondCount = 30
        }
    }
    
    @IBAction func noteButtonPress(sender: UIButton) {
        if buttonBool{
            var selectedAnswer = sender.titleLabel?.text
            userAnswer = selectedAnswer!
            
            checkAnswer()
            reset()
        }
        
    }
    
    func getRandomAnswer(){
        fretNumber = Int(arc4random_uniform(12))
        stringNumber = Int(arc4random_uniform(6)) + 1
        
        let notePosition = getFretNote()
        
        noteDotX.constant = notePosition.x
        noteDotY.constant = notePosition.y
        self.view.layoutIfNeeded()
        
        randomAnswer = fretNote
    }
    
    func getFretNote() -> CGPoint {
        
        var fretX: [CGFloat] = [44, 90, 142, 196, 253, 309, 364, 414, 458, 500, 540, 577]
        var newOrigin = CGPointZero
        if(stringNumber == 1){
            baseNote = "e"
            fretNote = eString[fretNumber]
            //noteDot.frame.origin.y = 24
            return CGPointMake(fretX[fretNumber], 24)
        }else if(stringNumber == 2){
            baseNote = "B"
            fretNote = BString[fretNumber]
            //noteDot.frame.origin.y = 47
            return CGPointMake(fretX[fretNumber], 47)
        }else if(stringNumber == 3){
            baseNote = "G"
            fretNote = GString[fretNumber]
            //noteDot.frame.origin.y = 68
            return CGPointMake(fretX[fretNumber], 68)
        }else if(stringNumber == 4){
            baseNote = "D"
            fretNote = DString[fretNumber]
            //noteDot.frame.origin.y = 89
            return CGPointMake(fretX[fretNumber], 89)
        }else if(stringNumber == 5){
            baseNote = "A"
            fretNote = AString[fretNumber]
            //noteDot.frame.origin.y = 110
            return CGPointMake(fretX[fretNumber], 110)
        }else if(stringNumber == 6){
            baseNote = "E"
            fretNote = eString[fretNumber]
            //noteDot.frame.origin.y = 129
            return CGPointMake(fretX[fretNumber], 129)
        }
        
        println("did not return a CGPoint. returning (0,0)")
        return CGPointZero
    }
    
    var score = 0
    func checkAnswer(){
        if(userAnswer == randomAnswer){
            score = score + 100
            correctCounter.text! = "\(score)"
        }else{
            if(score == 0){
                score = 0
            }else{
                score = score - 50
            }
            correctCounter.text! = "\(score)"
        }
    }
    
    func reset(){
        getRandomAnswer()
    }
    
    func endGame(){
        secondCount = 30
        timerView.text! = "\(secondCount)"
        
        correctCounter.text! = "\(score)"
        score = 0
        startButton.hidden = false
        buttonBool = false
        pauseButton.hidden = true
        noteDot.hidden = true
        
    }
    
    func endGameToStartNewGame(){
        correctCounter.text! = "0"
        secondCount = 30
        timerView.text! = "\(secondCount)"
        
        score = 0
        startButton.hidden = false
        buttonBool = false
        pauseButton.hidden = true
        noteDot.hidden = true
    }
    
    
    
    
    
    
    
    @IBAction func pauseGame(sender: UIButton) {
        if pauseBool{
            
        blurView.hidden = false
        
        let current = blurView.frame.origin
        let height = blurView.frame.height
        let offScreen = CGPointMake(current.x, current.y + height)
        blurView.frame.origin = offScreen
        
        UIView.animateWithDuration(0.25, animations: {
        self.blurView.frame.origin = current
        })
        
        
        timeAtPause = secondCount
        timer!.invalidate()
        pauseBool = false
        }
    }
    @IBAction func resumeGame(sender: UIButton) {
        pauseBool = false
        let current = blurView.frame.origin
        let height = blurView.frame.height
        let offScreen = CGPointMake(current.x, current.y + height)
        UIView.animateWithDuration(0.25, animations: {
            self.blurView.frame.origin = offScreen
            self.pauseBool = false
            }, completion: { success in
                self.blurView.hidden = true
                self.blurView.frame.origin = current
                self.secondCount = self.timeAtPause + 1
                self.startTimer()
                self.pauseBool = true
        })
        

    }
    @IBAction func restartGame(sender: UIButton) {
        endGame()
        reset()
        timer?.invalidate()
        blurView.hidden = true
        startGame(nil)
    }
    @IBAction func goToMainMenu(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName(returnToMainMenu, object: self)
        delay(0.5){
            self.blurView.hidden = true
        }
        endGameToStartNewGame()
        reset()
    }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

