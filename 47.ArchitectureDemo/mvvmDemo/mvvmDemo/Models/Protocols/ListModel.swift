//
//  ListModel.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation


protocol ListModel
{
    func items(_ completionHandler: @escaping (_ items: [DataItem]) -> Void)
}
