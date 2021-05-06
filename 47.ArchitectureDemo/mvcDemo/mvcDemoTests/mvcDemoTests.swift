//
//  mvcDemoTests.swift
//  mvcDemoTests
//
//  Created by jackfrow on 2021/5/5.
//

import XCTest
@testable import mvcDemo


class UserServiceMock: UserService {
    fileprivate let users: [User]

    init(users: [User]) {
        self.users = users
    }

    override func getUsers(_ callBack: @escaping ([User]) -> Void) {
        callBack(users)
    }
}




class mvcDemoTests: XCTestCase {

  
    
    let emptyUsersServiceMock = UserServiceMock(users: [User]())
    
    let twoUsersServiceMock = UserServiceMock(users:
                                                [User(firstName: "jack", lastName: "row", email: "jack@gmail.com", age: 24),
                                                 User(firstName: "jack2", lastName: "row2", email: "jack2@gamil.com", age: 28)])
    
    func testShouldSetEmpty() {
    
        
        //given
        let ViewControllerUnderTest = UserViewController(userService: emptyUsersServiceMock)
        
        
        //when
        ViewControllerUnderTest.getUsers()
        
        
        
    }
    
    
    
    func testShouldSetUsers() {
        
    }

}
