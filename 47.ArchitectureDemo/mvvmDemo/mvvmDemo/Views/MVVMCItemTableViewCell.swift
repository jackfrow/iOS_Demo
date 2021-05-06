//
//  MVVMCItemTableViewCell.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import UIKit

class MVVMCItemTableViewCell: UITableViewCell {

 
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: DataItem? {
        didSet {
            if let item = item {
                nameLabel.text = item.name
            } else {
                nameLabel.text = "Unknown"
            }
        }
    }
    
    
}
