//
//  StartScreen.swift
//  FretboardPracticeGame
//
//  Created by laptop on 5/11/15.
//  Copyright (c) 2015 DFA Film 11: Brian. All rights reserved.
//

import UIKit

let launchTimedGame = "launchTimedGame"
let launchClassicGame = "launchClassicGame"
let returnToMainMenu = "returnToMainMenu"

class StartScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func launchTimedGame(sender: UIButton) {
    
             //let quiz = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("quiz") as! QuizViewController
        //let timedGame = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("timedGame") as! UIViewController
         //self.presentViewController(timedGame, animated: true, completion: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("launchTimedGame", object: self)
    }
    
    
    @IBAction func launchClassicGame(sender: AnyObject) {
        
        //let classicGame = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("classicGame") as! UIViewController
        //self.presentViewController(classicGame, animated: true, completion: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("launchClassicGame", object: self)
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
