//
//  ItemController.swift
//  Unit2_ ShoppingList_Koch
//
//  Created by Dustin Koch on 5/10/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    static var shared = ItemController()
    var fetchedResultsController: NSFetchedResultsController<Item>
    
    init() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let isAddedDescriptor = NSSortDescriptor(key: "isAdded", ascending: true)
        fetchRequest.sortDescriptors = [isAddedDescriptor]
        let fetchedController: NSFetchedResultsController<Item> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "Added", cacheName: nil)
        fetchedResultsController = fetchedController
        //perform fetch
        do {
            try fetchedResultsController.performFetch()
        } catch  {
            print("👻 - Error performing fetch: \(error)")
        }
    }
    //MARK: - CRUD FUNCTIONS
    func createItem(name: String){
        let _ = Item(name: name)
        saveToPersistence()
    }
    
    func updateBool(item: Item){
        item.isAdded = !item.isAdded
        saveToPersistence()
    }
    
    func deleteItem(item: Item){
        CoreDataStack.context.delete(item)
        saveToPersistence()
    }
    
    func saveToPersistence(){
        do { let moc = CoreDataStack.context
            try moc.save()
        } catch  {
            print("💥 - Error saving to persistence: \(error)")
        }
    }
}//END OF CLASS

