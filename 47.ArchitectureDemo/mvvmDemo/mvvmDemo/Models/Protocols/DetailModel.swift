//
//  DetailModel.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation


protocol DetailModel
{
    func detail(_ completionHandler: @escaping (_ item: DataItem?) -> Void)
}
