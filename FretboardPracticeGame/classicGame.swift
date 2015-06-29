
//  ViewController.swift
//  FretboardPracticeGame
//
//  Created by DFA Film 11: Brian on 5/4/15.
//  Copyright (c) 2015 DFA Film 11: Brian. All rights reserved.
//

import UIKit



class ClassicGame: UIViewController {
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resumeGame", name: resumeGameNot, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "restartGame", name: restartGameNot, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToHome", name: goToHomeNot, object: nil)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        createEdgePath(self.view.frame.size)
        edgeLayer.alpha = 0.0
        let height = self.view.frame.height
        pauseContainerConstant.constant = -height
        correctCounter.hidden = true
        //homeButton.hidden = false
        super.viewDidAppear(false)
        
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
    
    @IBOutlet weak var fretboardImage: UIImageView!
    @IBOutlet weak var fretboardTopSpace: NSLayoutConstraint!
    @IBOutlet weak var fretboardLeading: NSLayoutConstraint!
    @IBOutlet weak var noteMarker: UIImageView!
    @IBOutlet weak var noteMarkerX: NSLayoutConstraint!
    @IBOutlet weak var noteMarkerY: NSLayoutConstraint!
    
    @IBOutlet weak var pauseContainerConstant: NSLayoutConstraint!
    
    @IBOutlet weak var homeButton: UIButton!
    
    
    var edgeShapeLayer: CAShapeLayer!
    var edgeLayer: UIView!
    
    
    var buttonBool = false
    var pauseBool = true
    
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
    
    var startTime = 7.0
    var current: CGFloat = 0.0
    var currentTime: Double = 0.0
    
    
    
    @IBAction func startGame(sender: UIButton?) {
        correctCounter.text! = "0"
        getRandomAnswer()
        
        startTimer()
        buttonBool = true
        pauseBool = true
        pauseButton.hidden = false
        startButton.hidden = true
        noteMarker.hidden = false
        correctCounter.hidden = false
        homeButton.hidden = true
        
        
        animateEdgeShapeLayer(false, current: 1.0, beginning: true, pause: false, timeToAnswer: startTime)
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
        
        noteMarkerX.constant = notePosition.x
        noteMarkerY.constant = notePosition.y
        self.view.layoutIfNeeded()
        
        randomAnswer = fretNote
    }
    
    func getFretNote() -> CGPoint {
        
        let width = fretboardImage.frame.width
        let height = fretboardImage.frame.height
        let xSpacing = width / 12
        let ySpacing = height / 7
        
        var fretX: [CGFloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for i in 0..<12 {
            fretX[i] = fretboardLeading.constant + (width/41) + (xSpacing * (CGFloat(i)))
        }
        
        var fretY: [CGFloat] = [0, 0, 0, 0, 0, 0]
        for i in 0..<6 {
            
            fretY[i] = fretboardTopSpace.constant + (ySpacing * (CGFloat(i))) + (noteMarker.frame.height)/3
            
        }
        
        
        var newOrigin = CGPointZero
        if(stringNumber == 1){
            baseNote = "e"
            fretNote = eString[fretNumber]
            //noteDot.frame.origin.y = 24
            return CGPointMake(fretX[fretNumber], fretY[0])
        }else if(stringNumber == 2){
            baseNote = "B"
            fretNote = BString[fretNumber]
            //noteDot.frame.origin.y = 47
            return CGPointMake(fretX[fretNumber], fretY[1])
        }else if(stringNumber == 3){
            baseNote = "G"
            fretNote = GString[fretNumber]
            //noteDot.frame.origin.y = 68
            return CGPointMake(fretX[fretNumber], fretY[2])
        }else if(stringNumber == 4){
            baseNote = "D"
            fretNote = DString[fretNumber]
            //noteDot.frame.origin.y = 89
            return CGPointMake(fretX[fretNumber], fretY[3])
        }else if(stringNumber == 5){
            baseNote = "A"
            fretNote = AString[fretNumber]
            //noteDot.frame.origin.y = 110
            return CGPointMake(fretX[fretNumber], fretY[4])
        }else if(stringNumber == 6){
            baseNote = "E"
            fretNote = eString[fretNumber]
            //noteDot.frame.origin.y = 129
            return CGPointMake(fretX[fretNumber], fretY[5] )
        }
        
        println("did not return a CGPoint. returning (0,0)")
        return CGPointZero
    }
    
    var score = 0
    func checkAnswer(){
        
        
        if let presentation = edgeShapeLayer.presentationLayer() as? CAShapeLayer {
            current = presentation.strokeEnd
            currentTime = presentation.duration
        }
        
        if(userAnswer == randomAnswer){
            score = score + 100
            correctCounter.text! = "\(score)"
            
            animateEdgeShapeLayer(true, current: current, beginning: false, pause: false, timeToAnswer: currentTime + (startTime * 0.4))
            
            //flash green if answer is right
            /*edgeShapeLayer.strokeColor = UIColor(hue: 0.333, saturation: 0.6, brightness: 0.8, alpha: 1.0).CGColor
            edgeLayer.alpha = 1.0
            self.view.layoutIfNeeded()
            delay(0.2){
                UIView.animateWithDuration(0.3, animations: {
                    self.edgeLayer.alpha = 0.0
                })
            }*/
        }else{
            if(score == 0){
                score = 0
            }else{
                score = score - 50
            }
            
            animateEdgeShapeLayer(false, current: current, beginning: false, pause: false, timeToAnswer: currentTime)
            //Flash red if answer is wrong
            /*edgeShapeLayer.strokeColor = UIColor(hue: 0.0, saturation: 0.6, brightness: 0.8, alpha: 1.0).CGColor
            edgeLayer.alpha = 1.0
            self.view.layoutIfNeeded()
            delay(0.2){
                UIView.animateWithDuration(0.3, animations: {
                    self.edgeLayer.alpha = 0.0
                })
            }*/
            
            correctCounter.text! = "\(score)"
        }
    }
    
    func reset(){
        getRandomAnswer()
    }
    
    func endGame(){
        secondCount = 30
        timerView.text! = "\(secondCount)"
        
        correctCounter.hidden = true
        correctCounter.text! = "\(score)"
        score = 0
        startButton.hidden = false
        buttonBool = false
        pauseButton.hidden = true
        noteMarker.hidden = true
        homeButton.hidden = false
        
    }
    
    func endGameToStartNewGame(){
        correctCounter.hidden = true
        homeButton.hidden = false
        secondCount = 30
        timerView.text! = "\(secondCount)"
        
        score = 0
        startButton.hidden = false
        buttonBool = false
        pauseButton.hidden = true
        noteMarker.hidden = true
    }
    
    
    
    var rootView: UIView?
    
    @IBAction func pauseGame(sender: UIButton) {
        if pauseBool{
            
            //Saves where the edgeShapeLayer is at at time of pause
            if let presentation = edgeShapeLayer.presentationLayer() as? CAShapeLayer {
                current = presentation.strokeEnd
                currentTime = presentation.duration
            }
            edgeLayer.alpha = 0.0
            UIView.animateWithDuration(0.2, animations: {
                self.view.layoutIfNeeded()
            })
            let viewHeight = self.view.frame.height
            pauseContainerConstant.constant = 0
            UIView.animateWithDuration(0.2, animations: {
                self.view.layoutIfNeeded()
            })
            
            timeAtPause = secondCount
            timer!.invalidate()
            pauseBool = false
        }
    }
    
    @IBAction func resumeGame() {
        
        animateEdgeShapeLayer(false, current: current, beginning: false, pause: true, timeToAnswer: currentTime)
        edgeLayer.alpha = 1.0
        UIView.animateWithDuration(0.2, animations: {
            self.view.layoutIfNeeded()
        })
        pauseBool = false
        let viewHeight = self.view.frame.height
        pauseContainerConstant.constant = -viewHeight
        UIView.animateWithDuration(0.2, animations: {
            self.pauseBool = false
            self.view.layoutIfNeeded()
            }, completion: { success in
                self.secondCount = self.timeAtPause + 1
                self.startTimer()
                self.pauseBool = true
        })
        
        
    }
    @IBAction func restartGame() {
        endGame()
        reset()
        timer?.invalidate()
        let viewHeight = self.view.frame.height
        pauseContainerConstant.constant = -viewHeight
        UIView.animateWithDuration(0.2, animations: {
            self.view.layoutIfNeeded()
        })
        delay(0.2){
            self.startGame(nil)
        }
    }
    @IBAction func goToHome() {
        NSNotificationCenter.defaultCenter().postNotificationName(returnToMainMenu, object: self)
        delay(0.5){
            let viewHeight = self.view.frame.height
            self.pauseContainerConstant.constant = -viewHeight
            UIView.animateWithDuration(0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }
        endGameToStartNewGame()
        reset()
    }
    
    func gameOver(){
        
        //small window jumps up from the bottom
        
    }
    
    
    func createEdgePath(screenSize: CGSize){
        
        let width = self.view!.frame.width
        let height = self.view!.frame.height
        
        let mutable = CGPathCreateMutable()
        CGPathMoveToPoint(mutable, nil, width/2, 0)
        CGPathAddLineToPoint(mutable, nil, width, 0)
        CGPathAddLineToPoint(mutable, nil, width, height)
        CGPathAddLineToPoint(mutable, nil, 0, height)
        CGPathAddLineToPoint(mutable, nil, 0, 0)
        CGPathAddLineToPoint(mutable, nil, width/2, 0)
        let path = CGPathCreateMutableCopy(mutable)
        
        edgeShapeLayer = CAShapeLayer()
        edgeShapeLayer.frame = self.view.frame
        edgeShapeLayer.path = path
        edgeShapeLayer.strokeColor = UIColor(hue: 0.333, saturation: 0.6, brightness: 0.8, alpha: 1.0).CGColor
        edgeShapeLayer.lineWidth = 20.0
        edgeShapeLayer.fillColor = nil
    
        
        edgeLayer = UIImageView(frame: self.view.frame)
        self.view.addSubview(edgeLayer)
        
        edgeLayer.layer.addSublayer(edgeShapeLayer)
        
    }
    
    func animateEdgeShapeLayer(correct: Bool, current: CGFloat, beginning: Bool, pause: Bool, timeToAnswer: Double){
        
        edgeLayer.alpha = 1.0
        edgeShapeLayer.strokeEnd = current
        
        var fillTime = 0.5
        
        //Drain Animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = current
        animation.toValue = CGFloat(0.0)
        animation.duration = timeToAnswer
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.additive = false
        animation.fillMode = kCAFillModeBackwards
        
        //Fill Animation
        let fillAnimation = CABasicAnimation(keyPath: "strokeEnd")
        fillAnimation.fromValue = current
        fillAnimation.toValue = current + CGFloat(0.4)
        fillAnimation.duration = fillTime
        fillAnimation.delegate = self
        fillAnimation.removedOnCompletion = false
        fillAnimation.additive = true
        fillAnimation.fillMode = kCAFillModeBackwards
        
        if correct && beginning == false {
            edgeShapeLayer.addAnimation(fillAnimation, forKey: "strokeEnd")
            delay(fillTime + 0.1){
                var newCurrent: CGFloat = 0.0
                if let presentation = self.edgeShapeLayer.presentationLayer() {
                    newCurrent = presentation.strokeEnd + CGFloat(0.4)
                }
                if (newCurrent > 1.0){
                    newCurrent = 1.0
                }
                animation.fromValue = newCurrent
                self.edgeShapeLayer.addAnimation(animation, forKey: "strokeEnd")
            }
        }else if (correct == false && beginning == false){
            edgeShapeLayer.addAnimation(animation, forKey: "strokeEnd")
            if pause == false{
                edgeShapeLayer.strokeColor = UIColor(hue: 0.0, saturation: 0.6, brightness: 0.8, alpha: 1.0).CGColor
                delay(0.2){
                    self.edgeShapeLayer.strokeColor = UIColor(hue: 0.333, saturation: 0.6, brightness: 0.8, alpha: 1.0).CGColor
                }
            }
            
        }else if beginning{
            edgeShapeLayer.addAnimation(animation, forKey: "strokeEnd")
        }
        
        if (edgeShapeLayer.strokeEnd == 0.0) {
            gameOver()
    
        
    }
    
   func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        edgeLayer.alpha = 0.0
    }
    
    
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

}