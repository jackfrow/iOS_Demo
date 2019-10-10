//
//  TestTwoViewController.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit

class TestTwoViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
         loadNext()

    }
    
    override func doLoad(handler: (Any?) -> Void) {
        print("打印一下")
    }


    
}
