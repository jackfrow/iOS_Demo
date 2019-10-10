//
//  diamond.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/9.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import Foundation

protocol Nameable {
    var name: String { get }
}
protocol Identifiable {
    var name: String { get }
    var id: Int { get }
}


//Type 'Person2' does not conform to protocol 'Nameable'
//Type 'Person2' does not conform to protocol 'Identifiable'

struct Person2: Nameable, Identifiable {
    let name: String
let id: Int }

// name 属性同时满足Nameable 和Identifiable 的name

extension Nameable {
    var name: String { return "default name" }
}


extension Identifiable {
    var name: String { return "another default name" }
}
