//
//  mStores.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/22/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import CoreData
import SwiftyJSON

class mStores {
    
    let global = Global()
    let modelHelper = ModelHelper()
    
    private let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func populate_data(){
        self.modelHelper.delete_all("Stores")
        self.global.request("\(self.global.base_url)/search", params: nil, headers: nil, type: HTTPTYPE.GET) { (response) in
            if response.count > 0 {
                for i in 0...response.count-1 {
                    let stores = NSEntityDescription.insertNewObjectForEntityForName("Stores", inManagedObjectContext: self.managedContext) as! Stores
                    stores.id = Int16(response[i]["id"].intValue)
                    stores.name = response[i]["name"].stringValue
                    stores.street = response[i]["street"].stringValue
                    stores.city = response[i]["city"].stringValue
                    stores.category = response[i]["category"].stringValue
                    stores.latitude = response[i]["latitude"].doubleValue
                    stores.longitude = response[i]["longitude"].doubleValue
                    stores.rate_score = response[i]["rate_score"].floatValue
                }
                
                do {
                    try self.managedContext.save()
                } catch let error as NSError  {
                    print("Could not save \(error)")
                }
            }
        }
    }
    
    func read_stores() -> [Stores]? {
        
        let fetchRequest = NSFetchRequest(entityName: "Stores")
        
        do {
            let results = try self.managedContext.executeFetchRequest(fetchRequest) as? [Stores]
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
            return nil
        }
        
    }
    
}