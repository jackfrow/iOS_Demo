//
//  P.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/9.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import Foundation

protocol P {
    func myMethod2()
}
extension P {
    func myMethod2() {
        print("协议扩展实现打印")
    }
    func myMethod3() {
        
        myMethod2()
        print("打印")
    }
}

class CrossSOne:P {}
class CrossSTwo:P {}

public func CrossSCall()  {
    
    let q1 = CrossSOne()
    let q2 = CrossSTwo()
    
    q1.myMethod2()
    q1.myMethod3()
    
    q2.myMethod2()
    q2.myMethod3()
    
}

