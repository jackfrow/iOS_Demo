//
//  protocol.swift
//  43.swiftLern
//
//  Created by jackfrow on 2021/4/25.
//

import Foundation



protocol Animal {
    func animal()
}


extension Animal{
    func animal()  {
        print("animal")
    }
}



class Dog: Animal {
    func animal()  {
        print("Dog")
    }
}


//TODO:swift 类不能做扩展？

//extension Dog{
//     func animal()  {
//        print("animal")
//    }
//}

enum VendingMachineError: Error {
    case invalidSelection                     //选择无效
    case insufficientFunds(coinsNeeded: Int) //金额不足
    case outOfStock                             //缺货
}





class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}



class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
       
    }
    convenience init() {
        self.init(name:"jack",director:"rose")
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}



//protocol SomeProtocol {
//    var doesNotNeedToBeSettable: Int { get set }
//}


protocol SomeProtocol {
    init(someParater:Int)
}


 class SomeClass: SomeProtocol {
    required init(someParater: Int) {
        
    }
    
    
}




struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}



class TestA {
    func test() {
        print("testA")
    }
}

extension TestA{
    
//    Invalid redeclaration of 'test()'
//    func test() {
//        print("testA")
//    }
    
}



protocol SomeClassOnlyProtocol: AnyObject {
    // 这里是类专属协议的定义部分
}


class SomeClassA:SomeClassOnlyProtocol {
    
}



struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}


struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
