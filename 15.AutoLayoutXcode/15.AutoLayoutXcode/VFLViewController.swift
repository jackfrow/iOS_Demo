//
//  VFLViewController.swift
//  15.AutoLayoutXcode
//
//  Created by yy on 2019/8/14.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit

class VFLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}
