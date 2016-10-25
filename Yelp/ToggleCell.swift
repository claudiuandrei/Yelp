//
//  ToggleCell.swift
//  Yelp
//
//  Created by Claudiu Andrei on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol ToggleCellDelegate: class {
    func updateCellToggle(cell: ToggleCell, value: Bool)
}

class ToggleCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryToggle: UISwitch!
    
    // Set the cell type
    var type: String! = "Deals"
    
    // Valus to actually keep in the cell
    var name: String! {
        didSet {
            categoryLabel.text = name
        }
    }
    
    // Set
    var toggle: Bool = false {
        didSet {
            categoryToggle.setOn(toggle, animated: true)
        }
    }
    
    // Setup the delegate
    weak var delegate: ToggleCellDelegate?
    
    // Where we toggle on/off
    @IBAction func toggleAction(_ sender: AnyObject) {
        delegate?.updateCellToggle(cell: self, value: categoryToggle.isOn)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
