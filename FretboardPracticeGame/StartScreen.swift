//
//  StartScreen.swift
//  FretboardPracticeGame
//
//  Created by laptop on 5/11/15.
//  Copyright (c) 2015 DFA Film 11: Brian. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func launchTimedGame(sender: UIButton) {
    
             //let quiz = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("quiz") as! QuizViewController
        let timedGame = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("timedGame") as! UIViewController
         self.presentViewController(timedGame, animated: true, completion: nil)
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
