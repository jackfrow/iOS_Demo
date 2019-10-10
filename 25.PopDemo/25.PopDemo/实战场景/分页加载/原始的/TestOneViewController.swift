//
//  TestOneViewController.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit



class TestOneViewController: BaseTableViewController {

    private var data: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadNext()
        
    }
    
    override func doLoad(handler: (Any?) -> Void) {
        
        print("dosomething")
        self.data = [ Friend(nickName: "张天")]
        self.tableView.reloadData()
    }



}
