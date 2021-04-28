//
//  basic.swift
//  43.swiftLern
//
//  Created by jackfrow on 2021/4/23.
//

import Foundation

func test1()  {
    let http404Error = (404, "Not Found")
    let (statusCode, statusMessage) = http404Error
    print("The status code is \(statusCode)")
    // 输出“The status code is 404”
    print("The status message is \(statusMessage)")
    // 输出“The status message is Not Found”
    
    
    let http200Status = (statusCode: 200, description: "OK")
    print("The status code is \(http200Status.statusCode)")
    // 输出“The status code is 200”
    print("The status message is \(http200Status.description)")
    // 输出“The status message is OK”
    
}



//可选值强制解析
func test2()  {
    let defaultColorName = "red"
    var userDefinedColorName: String?   //默认值为 nil

    var colorNameToUse = userDefinedColorName ?? defaultColorName
}


