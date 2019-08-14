//
//  ViewController.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/12.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
     
    }
    

    @IBAction func ShowLibrary(_ sender: Any) {
        
        JRPerMission.registerPhotoPermisson {
            
          let vc = JRPhotoViewController()
          let nav = UINavigationController(rootViewController: vc)
           self.present(nav, animated: true)
            
        }
        
    }
    
}

