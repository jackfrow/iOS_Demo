//
//  TestSwift.swift
//  test
//
//  Created by jackfrow on 2021/5/5.
//

import Foundation


class TestSwift: NSObject{
    @objc func testSwift(){
        NSLog("testSwift")
    }
    func sayHello(name :String) -> String {
            return name + "sayHello";
        }
}
