//
//  PauseMenu.swift
//  FretboardPracticeGame
//
//  Created by laptop on 6/24/15.
//  Copyright (c) 2015 DFA Film 11: Brian. All rights reserved.
//

import UIKit

let resumeGameNot = "resumeGame"
let restartGameNot = "restartGame"
let goToHomeNot = "goToHome"
class PauseMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resumeGame(sender: UIButton){
        NSNotificationCenter.defaultCenter().postNotificationName(resumeGameNot, object: self)
    }
    
    @IBAction func restartGame(sender: UIButton){
        NSNotificationCenter.defaultCenter().postNotificationName(restartGameNot, object: self)
    }
    
    @IBAction func goToHome(sender: UIButton){
        NSNotificationCenter.defaultCenter().postNotificationName(goToHomeNot, object: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
