//
//  ViewController.swift
//  43.swiftLern
//
//  Created by jackfrow on 2021/4/22.
//

import UIKit


class Person2 {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class ViewController: UIViewController {
    
    

    
    func swapTwoValues<D>(_ a: inout D, _ b: inout Int) {
    //    let temporaryA = a
    //    a = b
    //    b = temporaryA
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let test =  TestFrame()
//        test.test()
        
        Person2(name: "jack")
        
//        var a = 5,b = 6
        
//        swapTwoValues(&a, &b)
        
//        TestPermisson()
//        testReduce()
        

//        testProtocol()

        
//        var stack = Stack<Int>()
//        stack.push(5)
//        print("pop",stack.pop())
        


    }

    
    func test(a:Int,b:Int) -> (c:Int, b:Int) {
        return (a+1,b+1)
    }
    
    func testProtocol()  {
        let dog1:Animal = Dog()
        
//        if let dg = dog1 as? Dog {
//            dg.animal()
//        }
        
        dog1.animal()
        
        let dog2  = Dog()
        dog2.animal()
        
    }
    
    
    
   


}

class GTestA {
    
}

protocol GProtocolA {
    func test()
}

