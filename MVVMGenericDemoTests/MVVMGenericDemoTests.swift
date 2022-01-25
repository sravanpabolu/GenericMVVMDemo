//
//  MVVMGenericDemoTests.swift
//  MVVMGenericDemoTests
//
//  Created by Sravan on 25/01/22.
//

import XCTest
@testable import MVVMGenericDemo

class MVVMGenericDemoTests: XCTestCase {
    
    var userViewModel: UserViewModel?
    var users: [User]?
    
    override func setUpWithError() throws {
        userViewModel = UserViewModel(service: LocalManager(isValidURL: true))
        userViewModel?.getUsers()
        users = userViewModel?.users
    }

    override func tearDownWithError() throws {
        userViewModel = nil
        users = nil
    }

    func testUsers() throws {
        guard let users = users else {
            XCTAssertNil(users)
            return
        }
        XCTAssertNotNil(users)
        XCTAssertGreaterThan(users.count, 0)
    }
    
    func testUserDetail() {
        users?.forEach { user in
            XCTAssertNotNil(user.id)
            XCTAssertNotNil(user.email)
        }
    }
    
    func testParticularUserDetail() {
        let user = users?.first
        XCTAssertEqual(user?.id, 1)
        XCTAssertEqual(user?.email, "sravan@sravan.com")
    }
    
    func testURL() {
        XCTAssertEqual(Constants.usersUrl, "https://jsonplaceholder.typicode.com/users")
    }
    
    func testResponseError() {
        let expectation = expectation(description: "Testing Invalid Response")
        LocalManager(isValidURL: false).getData(endPoint: .users, type: [User].self, completion: { _, error in
            expectation.fulfill()
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.description(), NetworkError.urlError.description())
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
//    func testBundleUrl() {
//        guard let usersUrl = Bundle.main.url(forResource: "Users", withExtension: "json") else { return }
//        let url = userViewModel?.getUrl(urlString: String(describing: usersUrl))
//        XCTAssertNoThrow(NetworkError.urlError)
//        XCTAssertNotNil(url)
//    }
//
//    func testErrorUrl() {
//        _ = userViewModel?.getUrl(urlString: "ttepp\\")
//        XCTAssertNotNil(userViewModel?.errorString)
//        XCTAssertEqual(userViewModel?.errorString, "URL Error")
//    }
    
//    func testAnotherURL() {
//        userViewModel?.getUsers(urlString: "http://localhost:8080/")
//        XCTAssertNotNil(userViewModel?.errorString)
//    }
    
//    func testLocalUser() {
//        guard let usersUrl = Bundle.main.url(forResource: "ErrorUsers", withExtension: "json") else { return }
//        userViewModel?.getUsers(urlString: String(describing: usersUrl))
//        XCTAssertNotNil(userViewModel?.errorString)
//        XCTAssertEqual(userViewModel?.errorString, " Custom Error: The data couldn’t be read because it isn’t in the correct format.")
//    }
}
