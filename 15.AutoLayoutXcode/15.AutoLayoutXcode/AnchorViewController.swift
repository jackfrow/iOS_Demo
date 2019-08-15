//
//  AnchorViewController.swift
//  15.AutoLayoutXcode
//
//  Created by yy on 2019/8/14.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit


/// 布局锚点使用
class AnchorViewController: UIViewController {

    var blueView : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blueView)
        blueView.backgroundColor = UIColor.blue
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVc))
        blueView.addGestureRecognizer(tap)

        blueView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        blueView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        blueView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        blueView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
      
        
    }
    
    @objc func dismissVc(){
        
        dismiss(animated: true, completion: nil)
        
    }



}
