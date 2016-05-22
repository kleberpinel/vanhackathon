//
//  Delivery.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/22/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit
import SwiftyJSON

// Delivery
class Delivery: UIViewController {

    var cartData : CartData?
    var products_json = JSON("")
    
    @IBOutlet weak var labelStoreName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelStoreName.text = self.products_json["name"].stringValue
    }
    
}