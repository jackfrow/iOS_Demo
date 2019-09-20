//
//  ViewController.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/17.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewForLayer: UIView!
    
    var layer: CALayer {
        return viewForLayer.layer
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setUplayer()
        
    }
    
    func setUplayer()  {
        layer.backgroundColor = UIColor.blue.cgColor
        layer.borderWidth = 100.0
        layer.borderColor = UIColor.red.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 10.0
        layer.contents = UIImage(named: "star")?.cgImage
        layer.contentsGravity = CALayerContentsGravity.center
    }


}

