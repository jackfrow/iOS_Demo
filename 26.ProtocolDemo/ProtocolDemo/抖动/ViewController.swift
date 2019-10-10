//
//  ViewController.swift
//  ProtocolDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    
    @IBOutlet weak var image: FoodImageView!
    @IBOutlet weak var ActionBtn: ActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func takeAshake(_ sender: Any) {
        
        image.shake()
        ActionBtn.shake()
        
    }
    
}

