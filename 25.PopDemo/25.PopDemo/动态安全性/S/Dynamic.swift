//
//  Dynamic.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/9.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import Foundation


protocol Greetable {
    var name: String {get}
    func greet()
}

struct Person: Greetable  {
    let  name: String
    func greet() {
        print("你好 \(name)")
    }
    
}

struct Cat: Greetable{
    let name: String
    func greet() {
        print("meow~ \(name)")
    }
    
}

//struct Bug: Greetable {
//
//    let name: String
//   如果不把协议中的方法全部实现,会直接报错
//}

public func sayHi(){
    
    let array:[Greetable] = [Person(name: "Wei Wang "),
                            Cat(name: "onevcat")]
    
    for obj in array {
    
        obj.greet()
    }
    
}


