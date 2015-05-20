

import UIKit

class ContainerView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "animateToLeftView", name: launchTimedGame, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "animateToRightView", name: launchClassicGame, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToMenuFromLeft", name: returnToMainMenu, object: nil)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var timedGameConstant: NSLayoutConstraint!
    @IBOutlet weak var classicGameConstant: NSLayoutConstraint!
    @IBOutlet weak var startScreenConstant: NSLayoutConstraint!

    @IBOutlet weak var startScreen: UIView!
    @IBOutlet weak var timedGame: UIView!
    @IBOutlet weak var classicGame: UIView!
    
    
    override func viewWillAppear(animated: Bool) {
        let width = startScreen.frame.width
        timedGameConstant.constant = width/4
        classicGameConstant.constant = width/4
        startScreenConstant.constant = 0
        self.view.layoutIfNeeded()
    }
    
    func animateToLeftView(){
        timedGameConstant.constant = 0
        startScreenConstant.constant = -(startScreen.frame.width)
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: nil, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateToRightView(){
        classicGameConstant.constant = 0
        startScreenConstant.constant = startScreen.frame.width
        timedGameConstant.constant = startScreen.frame.width
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: nil, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func goToMenuFromLeft(){
        
        classicGameConstant.constant = (startScreen.frame.width)/4
        timedGameConstant.constant = startScreen.frame.width
        startScreenConstant.constant = 0
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: nil, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
