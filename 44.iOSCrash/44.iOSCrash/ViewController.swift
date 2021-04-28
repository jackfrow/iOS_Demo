//
//  ViewController.swift
//  44.iOSCrash
//
//  Created by jackfrow on 2021/4/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
    }

    @IBAction func crash(_ sender: UIButton) {
        
        let arrs = ["1","2","3","4"]
        print("num \(arrs[4])")
     
    }
    
}

