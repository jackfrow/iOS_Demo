//
//  FriendsTableViewController.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit


struct Friend {
    
    var nickName: String

}

class FriendsTableViewController: UITableViewController {

    private var lastId: Int? = nil
    private var hasNext = true
    private var data: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func load()  {
         if hasNext {
             
             self.lastId = 9528
             self.hasNext = false
             self.data = [Friend(nickName: "天上云下")]
             self.tableView.reloadData()
             
         }
     }

}
