//
//  Splash.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/22/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit

// Splash - Load models
class Splash: UIViewController {

    @IBOutlet weak var labelRefreshIcon: UIButton!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelInternetConnection: UILabel!
    
    // timer to animate the label
    var timer = NSTimer()
    var animationIndex = 0
    let animationDescription = ["Loading.","Loading..","Loading..."]
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.load_data()
    }
    
    func load_data(){
        if Connection.isON() {
            
            notConnected(false)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(Splash.animateLabel), userInfo: nil, repeats: true)
            
            // populate store's model - core data
            let stores = mStores()
            stores.populate_data() { (response) in
                dispatch_async(dispatch_get_main_queue()) {
                    self.timer.invalidate()
                    self.performSegueWithIdentifier("transSplashToMap", sender: nil)
                }
            }
            
        } else {
            notConnected(true)
        }
    }
    
    @IBAction func refreshIconClick(sender: AnyObject) {
        self.load_data()
    }
    
    
    func animateLabel(){
        if animationIndex == 3 {
            animationIndex = 0
        } else {
            self.labelDescription.text = animationDescription[animationIndex]
            animationIndex += 1
        }
    }
    
    // hide and show label if the internet is on or off
    func notConnected(status: Bool){
        if status == false {
            self.labelDescription.hidden = false
            self.labelRefreshIcon.hidden = true
            self.labelInternetConnection.hidden = true
        } else {
            self.labelDescription.hidden = true
            self.labelRefreshIcon.hidden = false
            self.labelInternetConnection.hidden = false
        }
    }
    
}