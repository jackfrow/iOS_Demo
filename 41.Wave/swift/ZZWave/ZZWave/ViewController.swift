//
//  ViewController.swift
//  ZZWave
//
//  Created by jackfrow on 2019/7/5.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var waveView : ZZWaveView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        waveView = ZZWaveView(frame: CGRect(x: (UIScreen.main.bounds.width - 200)/2.0, y: 200, width: 200, height: 200))
        waveView.text = "RD"
        waveView.color = UIColor.red
        waveView.layer.cornerRadius = 100
        waveView.layer.masksToBounds = true
        waveView.layer.borderColor = UIColor.lightGray.cgColor
        waveView.layer.borderWidth = 0.5
        view.addSubview(waveView)
        
        //start.
        waveView.startAnimation()
        
    }


}

