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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stores = mStores()
        stores.populate_data()
        
        NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(Splash.goToMap), userInfo: nil, repeats: true)
            
    }
    
    func goToMap(){
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("transSplashToMap", sender: nil)
        }
    }
    
}