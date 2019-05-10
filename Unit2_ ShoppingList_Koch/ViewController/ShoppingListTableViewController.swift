//
//  ShoppingListTableViewController.swift
//  Unit2_ ShoppingList_Koch
//
//  Created by Dustin Koch on 5/10/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ShoppingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.fetchedResultsController.delegate = self
    }
    
    //MARK: - IB ACTION
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentAlertController()
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionNumber = Int(ItemController.shared.fetchedResultsController.sections?[section].name ?? "zero")
        if sectionNumber == 0 {
            return "🆕 NEED TO BUY 🆕"
        } else {
            return "🤟🏽 Purchased 🤟🏽"
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ItemController.shared.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        let item = ItemController.shared.fetchedResultsController.object(at: indexPath)
        cell.update(item: item)
        cell.delegate = self

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = ItemController.shared.fetchedResultsController.object(at: indexPath)
            ItemController.shared.deleteItem(item: item)
        }
    }
    //ALERT CONTROLLER
    func presentAlertController(){
        let alertController = UIAlertController(title: "Shopping Items", message: "Add shopping item here 👇🏽", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter item..."
        }
        let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction.init(title: "Add Item", style: .default) { (_) in
            guard let itemText = alertController.textFields?.first?.text,
                alertController.textFields?.first?.text != "" else { return }
            ItemController.shared.createItem(name: itemText)
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}//END OF CLASS
//Delegate extension
extension ShoppingListTableViewController: ItemTableViewCellDelegate {
    func updateAddedStatus(cell: ItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = ItemController.shared.fetchedResultsController.object(at: indexPath)
        ItemController.shared.updateBool(item: item)
        cell.update(item: item)
    }
}//END OF EXTENSION

//NSFetchedResultsController Delegate

extension ShoppingListTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
}//END OF EXTENSION
