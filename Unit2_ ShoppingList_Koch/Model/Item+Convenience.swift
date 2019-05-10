//
//  Item+Convenience.swift
//  Unit2_ ShoppingList_Koch
//
//  Created by Dustin Koch on 5/10/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    convenience init(name: String, isAdded: Bool = false, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.name = name
        self.isAdded = isAdded
    }
}// END OF EXTENSION
