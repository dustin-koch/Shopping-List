//
//  ItemTableViewCell.swift
//  Unit2_ ShoppingList_Koch
//
//  Created by Dustin Koch on 5/10/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

protocol ItemTableViewCellDelegate: class {
    func updateAddedStatus(cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shoppingItemLabel: UILabel!
    @IBOutlet weak var boxButton: UIButton!
    
    weak var delegate: ItemTableViewCellDelegate?


    @IBAction func boxButtonTapped(_ sender: UIButton) {
        delegate?.updateAddedStatus(cell: self)
    }
    
    func updateButton(_ isAdded: Bool){
        let imageName = isAdded ? "checked" : "unchecked"
        boxButton.setImage(UIImage(named: imageName), for: .normal)
    }

}//END OF CLASS

extension ItemTableViewCell {
    func update(item: Item){
        shoppingItemLabel.text = item.name
        updateButton(item.isAdded)
    }
}
