//
//  ModelHelper.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/22/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit
import CoreData

struct ModelHelper {
    
    internal let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func delete_all(entity: String){
        
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all - error : \(error) \(error.userInfo)")
        }
        
    }
    
}