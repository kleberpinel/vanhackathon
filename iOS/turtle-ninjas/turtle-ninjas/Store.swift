//
//  Store.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/21/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit
import MapKit
import Haneke
import SwiftyJSON
import CoreLocation

class Store: UIViewController {
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var store_id : Int!
    
    let global = Global()
    var products_json = JSON("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "\(self.global.base_url)/merchants/\(store_id)"
        self.global.request(url, params: nil, headers: nil, type: HTTPTYPE.GET) { (response) in
            self.products_json = response
            dispatch_async(dispatch_get_main_queue(), {
                self.storeName.text = response["name"].stringValue
                self.tableView.reloadData()
            })
        }
        
    }
    
    @IBAction func backButtonClick(sender: AnyObject) {
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("nProducts", forIndexPath: indexPath) as! StoreProducts
        
        let row = indexPath.row
        
        cell.productName.text = self.products_json["products"][row]["name"].stringValue
        cell.productPrice.text = self.products_json["products"][row]["price"].stringValue
        
        if let avatarURL = NSURL(string: self.products_json["products"][row]["image_url"].stringValue) {
            cell.productAvatar.hnk_setImageFromURL(avatarURL, placeholder: nil, success: { (image) -> Void in
                cell.productAvatar.image = image
            }, failure: { (error) -> Void in
                
            })
        }
        
        return cell
        
    }
    
}