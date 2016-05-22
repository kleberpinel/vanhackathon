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

enum CartManager {
    case ADD
    case DELETE
}

struct CartData {
    var indexPaths = [Int: NSIndexPath]()
    var items = [Int: String]()
}

class Store: UIViewController {
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var store_id : Int!
    
    let global = Global()
    var cartData = CartData()
    
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
    
    @IBAction func addItemToCart(sender: AnyObject) {
        self.manageCart(CartManager.ADD, row: sender.tag)
    }
    
    @IBAction func removeItem(sender: AnyObject) {
        self.manageCart(CartManager.DELETE, row: sender.tag)
    }
    
    func manageCart(option: CartManager, row: Int){
        
        var quantity = 0
        let cell = self.tableView.cellForRowAtIndexPath(cartData.indexPaths[row]!)! as! StoreProducts
        let price = self.products_json["products"][row]["price"].floatValue
        
        if option == .ADD {
            quantity = Int(cell.productQuantity.text!)! + 1
            self.totalAmount.text = String(Float(totalAmount.text!)! + price)
        } else {
            if cell.productQuantity.text != "0" {
                quantity = Int(cell.productQuantity.text!)! - 1
                self.totalAmount.text = String(Float(totalAmount.text!)! - price)
            }
        }
        
        self.cartData.items[row] = String(quantity)
        
        cell.productQuantity.text = String(quantity)
        cell.productPrice.text = "$" + String(price * Float(quantity))
        
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
        
        if let avatarURL = NSURL(string: self.products_json["products"][row]["image_url"].stringValue) {
            cell.productAvatar.hnk_setImageFromURL(avatarURL, placeholder: nil, success: { (image) -> Void in
                cell.productAvatar.image = image
            }, failure: { (error) -> Void in
                cell.productAvatar.image = nil
            })
        }
        
        cell.minusIcon.tag = row
        cell.plusIcon.tag = row
        
        if (self.cartData.items[row] != nil) {
            cell.productQuantity.text = self.cartData.items[row]
            cell.productPrice.text = String(Double(self.cartData.items[row]!)! * self.products_json["products"][row]["price"].doubleValue)
        } else {
            cell.productQuantity.text = "0"
            cell.productPrice.text = "$0.00"
        }
        
        if self.cartData.indexPaths[indexPath.row] != indexPath {
            self.cartData.indexPaths[indexPath.row] = indexPath
        }
        
        return cell
        
    }
    
}