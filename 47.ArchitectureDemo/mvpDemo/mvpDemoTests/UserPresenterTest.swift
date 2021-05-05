//
//  mvpDemoTests.swift
//  mvpDemoTests
//
//  Created by jackfrow on 2021/5/4.
//

import XCTest
@testable import mvpDemo


class UserServiceMock: UserService {
    fileprivate let users: [User]

    init(users: [User]) {
        self.users = users
    }

    override func getUsers(_ callBack: @escaping ([User]) -> Void) {
        callBack(users)
    }
}


class UserViewMock: NSObject,UserView {

    var setUsersCalled = false
    var setEmptyUsersCalled = false

    func setUsers(_ users: [UserViewData]) {
        setUsersCalled = true
    }

    func setEmptyUsers() {
        setEmptyUsersCalled = true
    }

    func startLoading() {

    }

    func finishLoading() {

    }
}

class UserPresenterTest: XCTestCase {


    let emptyUsersServiceMock = UserServiceMock(users: [User]())
    
    let twoUsersServiceMock = UserServiceMock(users:
                                                [User(firstName: "jack", lastName: "row", email: "jack@gmail.com", age: 24),
                                                 User(firstName: "jack2", lastName: "row2", email: "jack2@gamil.com", age: 28)])
    

    
    func testShouldSetEmpty() {
        //given
        let userMock = UserViewMock()
        let userPresenterUnderTest = UserPresenter(userService: emptyUsersServiceMock)
        userPresenterUnderTest.attachView(userMock)

        //when
        userPresenterUnderTest.getUsers()


        //verify
        XCTAssertTrue(userMock.setEmptyUsersCalled)


    }
    
    
    func testShouldSetUsers() {

        //given
        let userViewMock = UserViewMock()
        let userPresenterUnderTest = UserPresenter(userService: twoUsersServiceMock)
        userPresenterUnderTest.attachView(userViewMock)


        //when
        userPresenterUnderTest.getUsers()

        //verify
        XCTAssertTrue(userViewMock.setUsersCalled)

    }
    
    
    
    

}
