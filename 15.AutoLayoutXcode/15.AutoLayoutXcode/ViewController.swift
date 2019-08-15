//
//  ViewController.swift
//  15.AutoLayoutXcode
//
//  Created by yy on 2019/8/14.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var redView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
  
        redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showAnchor))
        redView.addGestureRecognizer(tap)

//       NSLog("%@", redView.constraints)
        
        //左侧与父视图对齐
        let leftConstraint = NSLayoutConstraint(item: redView!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        //右侧与父视图对齐
        let rigthConstraint = NSLayoutConstraint(item: redView!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        //顶部在父视图顶部下方100
        let topConstraint = NSLayoutConstraint(item: redView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 100)

        //高度为父视图高度的一半
        let heightConstraint = NSLayoutConstraint(item: redView!, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.5, constant: 0)
        
//          iOS 6.0或者7.0调用addConstraints
//        let Constraint = [leftConstraint,rigthConstraint,topConstraint,bottomConstraint]
//        view.addConstraints(Constraint)
        
//        iOS 8.0以后设置每个约束的active属性值为YES
        leftConstraint.isActive = true
        rigthConstraint.isActive = true
        topConstraint.isActive = true
        heightConstraint.isActive = true
        //集体设置
//        [NSLayoutConstraint.activate(<#T##constraints: [NSLayoutConstraint]##[NSLayoutConstraint]#>)]
        
        view.addSubview(showVFL)
        
    }

    @objc func showAnchor(){
        
        let vc = AnchorViewController()
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func showVfl(){
        
        let vc = VFLViewController()
         present(vc, animated: true, completion: nil)
        
    }
    
    lazy var showVFL: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("VFL", for: .normal)
        btn.addTarget(self, action: #selector(showVfl), for: .touchUpInside)
        btn.frame  = CGRect(x: 200, y: 200, width: 100, height: 100)
        return btn
    }()
    
    

}

