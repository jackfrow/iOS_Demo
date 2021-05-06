//
//  MVVMCDataItem.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation


struct MVVMCDataItem: DataItem
{
    let name: String
    let role: String
    
    init(name: String, role: String)
    {
        self.name = name
        self.role = role
    }
}
