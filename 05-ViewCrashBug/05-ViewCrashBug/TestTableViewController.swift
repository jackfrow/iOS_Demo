//
//  TestTableViewController.swift
//  05-ViewCrashBug
//
//  Created by jackfrow on 2018/12/28.
//  Copyright © 2018 jackfrow. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //uitableview是一个懒加载，如果视图没有被加载过，在控制器销毁时便会去加载，所以就会造成异常.
        self.tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(change as Any)
    }
    

    deinit {
            self.tableView.removeObserver(self, forKeyPath: "contentOffset")
    }

   
}
