//
//  Store.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/21/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import CoreLocation

class Store: UIViewController {
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let global = Global()
    var products_json = JSON("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "\(self.global.base_url)"
        self.global.request(url, params: nil, headers: nil, type: HTTPTYPE.GET) { (response) in
            self.products_json = response
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func checkoutButtonClick(sender: AnyObject) {
    }
    
    //
    // mark: tableView funcs
    // 
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products_json.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Products", forIndexPath: indexPath) as! StoreProducts
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
}