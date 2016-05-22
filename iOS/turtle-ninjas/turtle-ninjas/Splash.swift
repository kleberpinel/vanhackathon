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
        stores.populate_data() { (response) in
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("transSplashToMap", sender: nil)
            }
        }
        
    }
    
}