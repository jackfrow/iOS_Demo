//
//  UserPresenter.swift
//  mvpDemo
//
//  Created by jackfrow on 2021/5/4.
//

import Foundation


struct UserViewData {
    let name: String
    let age: String
}

protocol UserView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setUsers(_ users: [UserViewData])
    func setEmptyUsers()
}

class UserPresenter  {
    fileprivate let userService:UserService
    weak fileprivate var userView: UserView?
    
    init(userService:UserService) {
        self.userService = userService
    }
    
    func attachView(_ view:UserView)  {
        userView = view
    }
    
    func detachView()  {
        userView = nil
    }
    
    func getUsers()  {
        self.userView?.startLoading()
        userService.getUsers {[weak self] users in
            self?.userView?.finishLoading()
            
            if users.count == 0 {
                self?.userView?.setEmptyUsers()
            }else{
                let mappedUsers = users.map { (user) -> UserViewData in
                    return UserViewData(name: "\(user.firstName) \(user.lastName)", age: "\(user.age)")
                }
                self?.userView?.setUsers(mappedUsers)
            }
            
        }
    }
}

