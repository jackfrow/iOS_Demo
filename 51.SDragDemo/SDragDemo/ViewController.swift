//
//  ViewController.swift
//  SDragDemo
//
//  Created by jackfrow on 2023/4/3.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dgv = SGDragView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 400 + 250, width:UIScreen.main.bounds.width , height: 400))
        dgv.backgroundColor = UIColor.green
        
        self.view.addSubview(dgv)
        
    }


}

