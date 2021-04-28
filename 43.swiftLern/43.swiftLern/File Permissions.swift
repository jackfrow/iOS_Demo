//
//  test.swift
//  43.swiftLern
//
//  Created by jackfrow on 2021/4/22.
//


//private 表示代码只能在当前作用域或者同一文件中同一类型的作用域中被使用，
//fileprivate 表示代码可以在当前文件中被访问，而不做类型限定。

import Foundation

class Person: NSObject {
    
    fileprivate var name:String = "man"
    
    private var age:Int = 1
    
    func testA() {
        print("testA")
    }

}


class Student: Person {
    override func testA() {
        print("testB")
    }
}

extension Person{
    
    func printAge()  {
         print(self.age)
         //在 当前文件的 extension 中，调用private 修饰的属性没问题
     }
     
     func prinName()  {
       //在 当前文件的 extension 中，调用fileprivate 修饰的属性没问题
         print(self.name)
     }
}

func TestPermisson()  {
    
    let p = Person()
    
    p.testA()
    
    print("name=",p.name)
    
    p.printAge()
    
    p.prinName()
    
//    'age' is inaccessible due to 'private' protection level
//    print("age=",p.age)
    
    
    
}



struct PersonS {
    fileprivate var name:String = "man"
    
    private var age:Int = 1
    
    
    func printAge()  {
         print(self.age)
         //在 当前文件的 extension 中，调用private 修饰的属性没问题
     }
     
     func prinName()  {
       //在 当前文件的 extension 中，调用fileprivate 修饰的属性没问题
         print(self.name)
     }
}

func TestPermisson2() {
    let p = PersonS()
    
    print("name=",p.name)

    p.printAge()
    
    p.prinName()
}
