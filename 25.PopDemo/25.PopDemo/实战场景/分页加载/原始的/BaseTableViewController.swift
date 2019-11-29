//
//  BaseTableViewController.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit


class BaseTableViewController: UITableViewController {

    var lastId: Int? = nil
    var hasNext = true
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadNext() {
    if isLoading { return }
    if hasNext {
    isLoading = true
    doLoad {result in
    self.lastId = 9981
    self.hasNext = false
        };
    }
    }

    func doLoad(handler: (Any?)->Void) { // ??
       
    }


}
