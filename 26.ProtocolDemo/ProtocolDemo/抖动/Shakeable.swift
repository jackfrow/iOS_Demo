//
//  Shakeable.swift
//  ProtocolDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import Foundation
import UIKit


protocol Shakeable {
    
}

extension Shakeable where Self: UIView{
    
    
        func shake() {
              let animation = CABasicAnimation(keyPath: "position")
              animation.duration = 0.05
              animation.repeatCount = 5
              animation.autoreverses = true
              animation.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
              animation.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
            layer.add(animation, forKey: "positionAnimation")
    
          }
    
}


protocol Dimmable {

}

extension Dimmable{
    
    func Dimm()  {
        
        print("调暗")
        
    }
    
}
