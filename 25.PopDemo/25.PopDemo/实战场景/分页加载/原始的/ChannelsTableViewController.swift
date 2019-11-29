//
//  ChannelsTableViewController.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit

struct Channel {
    
    var name: String
    
    
}

class ChannelsTableViewController: UITableViewController {

    private var lastId: Int? = nil
    private var hasNext = true
    private var data: [Channel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
        
    }
    
    func load()  {
        
        if hasNext {
            
            self.lastId = 9527
            self.hasNext = false
            self.data = [Channel(name: "吕布")]
            self.tableView.reloadData()
            
        }
    }

}


