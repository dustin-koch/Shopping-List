//
//  CoreDataStack.swift
//  Unit2_ ShoppingList_Koch
//
//  Created by Dustin Koch on 5/10/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import CoreData

import Foundation
import CoreData

class CoreDataStack {
    static let container: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "Unit2_ShoppingList_Koch")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Unresolved Error: \(error)")
            }
        })
        return persistentContainer
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}//END OF CLASS
