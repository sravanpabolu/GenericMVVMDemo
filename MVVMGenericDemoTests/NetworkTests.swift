//
//  NetworkTests.swift
//  MVVMGenericDemoTests
//
//  Created by Sravan on 24/01/22.
//

import XCTest
@testable import MVVMGenericDemo

class NetworkTests: XCTestCase {
    var networkManager: NetworkManager?

    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }
    
//    func testErrorUrl() {
//        do {
//            _ = try networkManager?.getURL(urlString: "ttepp\\")
//        } catch {
//            XCTAssertNotNil(NetworkError.urlError)
//        }
//    }
    
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
    
    func testNetworkUsers() {
        let expectation = expectation(description: "Testing Network Users")
        networkManager?.getData(endPoint: .users, type: [User].self, completion: { users, _ in
            expectation.fulfill()
            XCTAssertNotNil(users)
            XCTAssertGreaterThan(users?.count as! Int, 0)
        })
        waitForExpectations(timeout: 5, handler: nil)
    }

//    func testLocalHostURL() {
//        let urlStr = "http://localhost:8080/"
//        guard let url = URL(string: urlStr) else { return }
//        let expectation = expectation(description: "Testing localhost Response")
//        networkManager?.getData(endPoint: .users, type: [User].self, completion: { _, error in
//            expectation.fulfill()
//            XCTAssertNotNil(error)
//        })
//        waitForExpectations(timeout: 5, handler: nil)
//    }
}
