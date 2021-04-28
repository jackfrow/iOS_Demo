//
//  _3_swiftLernTests.swift
//  43.swiftLernTests
//
//  Created by jackfrow on 2021/4/22.
//

import XCTest
@testable import _3_swiftLern


class _3_swiftLernTests: XCTestCase {

  
    
    func testDefault()  {
        let defaultColorName = "red"
        var userDefinedColorName: String?   //默认值为 nil
        var colorNameToUse = userDefinedColorName ?? defaultColorName
        assert(colorNameToUse == "red")
        
        userDefinedColorName = "green"
         colorNameToUse = userDefinedColorName ?? defaultColorName
        assert(colorNameToUse == "green")
        

        
    }
    
    func  testCharacter(){
        for character in "Dog!🐶" {
            print(character)
        }
    
    }

    
    func testMethod() {
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
    }
    
    
    
   

}
