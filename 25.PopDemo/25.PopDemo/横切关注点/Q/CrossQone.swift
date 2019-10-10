//
//  CrossQone.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/9.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit

class CrossQone: NSObject {

    func myMethod()  {
        print("打印自己")
    }
    
}

class CrossQtwo: NSObject {

    func myMethod()  {
           print("打印自己")
       }
    
}

public func CrossQCall()  {
    
    let q1 = CrossQone()
    let q2 = CrossQtwo()
    
    q1.myMethod()
    q2.myMethod()
    
}
