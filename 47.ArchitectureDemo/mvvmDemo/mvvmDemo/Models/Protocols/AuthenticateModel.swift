//
//  AuthenticateModel.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation


protocol AuthenticateModel
{
    func login(email: String, password: String, completionHandler: @escaping (_ error: NSError?) ->())
}
