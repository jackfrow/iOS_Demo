//
//  MVVMCAuthenticateModel.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation


class MVVMCAuthenticateModel: AuthenticateModel
{
    func login(email: String, password: String, completionHandler: @escaping (_ error: NSError?) ->())
    {
        
        // Simulate Aysnchronous data access
        DispatchQueue.global().async {
            var error: NSError? = nil
            if email != "scotty@example.com" || password != "password" {
                error = NSError(domain: "MVVM-C",
                                code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Invalid Email or Password"])
            }
            completionHandler(error)
        }
    }
}
