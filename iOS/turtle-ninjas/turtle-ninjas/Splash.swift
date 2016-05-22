//
//  Splash.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/22/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit

// Splash - load models
class Splash: UIViewController {

    @IBOutlet weak var labelRefreshIcon: UIButton!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelInternetConnection: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.load_data()
    }
    
    func load_data(){
        if Connection.isON() {
            notConnected(false)
            let stores = mStores()
            stores.populate_data() { (response) in
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("transSplashToMap", sender: nil)
                }
            }
        } else {
            self.labelDescription.hidden = true
            self.labelRefreshIcon.hidden = false
            self.labelInternetConnection.hidden = false
        }
    }
    
    @IBAction func refreshIconClick(sender: AnyObject) {
        load_data()
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