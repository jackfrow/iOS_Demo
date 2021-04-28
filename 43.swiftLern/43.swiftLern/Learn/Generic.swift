//
//  Generic.swift
//  43.swiftLern
//
//  Created by jackfrow on 2021/4/26.
//

import Foundation



func findIndex<T:Equatable>(of valueToFind: T, in array:[T])  -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

