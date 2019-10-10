//
//  NextPage.swift
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import Foundation
import UIKit

struct NextPageState<T> {
     private(set) var hasNext: Bool
     private(set) var isLoading: Bool
     private(set) var lastId: T?
    
    init() {
        hasNext = true
        isLoading = false
        lastId = nil
    }
    
   mutating func reset()  {
        hasNext = true
        isLoading = false
        lastId = nil
    }
    
    mutating func update(hasNext: Bool,isLoading: Bool,lastId: T?){
        self.hasNext = hasNext
        self.isLoading = isLoading
        self.lastId = lastId
    }
    
    
}

protocol NextPageLoadable: class{
    associatedtype DataType
    associatedtype LastIdType
    
    var data: [DataType] {get set}
    var nextPageState: NextPageState<LastIdType> {get set}
    func performLoad(
        successHandler:(
        _ rows: [DataType],
        _ hasNext: Bool,
        _ lastId: LastIdType?
        ) -> (),
        failHandler: ()->()
    )
    
}


