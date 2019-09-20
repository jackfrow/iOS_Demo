//
//  TiledLayer.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/19.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

var adjustableFadeDuration: CFTimeInterval = 0.25

class TiledLayer: CATiledLayer {

    override class func fadeDuration() -> CFTimeInterval {
      return adjustableFadeDuration
    }
    
    class func setFadeDuration(_ duration: CFTimeInterval) {
      adjustableFadeDuration = duration
    }
    
}
