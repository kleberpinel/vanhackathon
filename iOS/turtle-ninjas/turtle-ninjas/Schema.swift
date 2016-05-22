//
//  Schema.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/22/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import Foundation
import CoreData

@objc(Stores)
public class Stores: NSManagedObject {
    @NSManaged var id: Int16
    @NSManaged var name: String
    @NSManaged var street: String
    @NSManaged var city: String
    @NSManaged var category: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var rate_score: Float
}