//
//  Closure.swift
//  43.swiftLern
//
//  Created by jackfrow on 2021/4/24.
//

import Foundation



class Clourse {
    
    func test01() {
        var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        names.sort { (a, b) -> Bool in
            return a > b
        }
    
    }
    
    
    func test02() {
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        let strings = numbers.map {
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        
        print("strings ",strings)
        
        // strings 常量被推断为字符串类型数组，即 [String]
        // 其值为 ["OneSix", "FiveEight", "FiveOneZero"]
    }
    
}

