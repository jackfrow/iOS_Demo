//
//  ViewController.swift
//  05-ViewCrashBug
//
//  Created by jackfrow on 2018/12/28.
//  Copyright © 2018 jackfrow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        testJson()
        
    }
    
    
    func testJson()  {
        
       let str = "赵云"
        let data = str.data(using: .utf8)
        
        do {
            try  let json =  JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            
            
        } catch  {
            
            print("decode failed")
            
        }

        
        
    }
    
    


}

