//
//  ScrollingView.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/18.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

class ScrollingView: UIView {

    override class var layerClass : AnyClass {
      return CAScrollLayer.self
    }
    
}
