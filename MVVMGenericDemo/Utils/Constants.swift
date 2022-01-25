//
//  Constants.swift
//  MVVMGenericDemo
//
//  Created by Sravan on 21/01/22.
//

import Foundation

enum EndPoint: String {
    case posts
    case users
    
    func getUrl() -> String {
        switch self {
        case .posts:
            return Constants.postsUrl
        case .users:
            return Constants.usersUrl
        }
    }
}

enum NetworkError: Error {
    case urlError
    case responseError
    case customError(description: String)
    
    func description() -> String {
        switch self {
        case .urlError:
            return "URL Error"
        case .responseError:
            return "Response Error"
        case .customError(let description):
            return "Custom Error : \(description)"
        }
    }
}


struct Constants {
    static let usersUrl = "https://jsonplaceholder.typicode.com/users"
    static let postsUrl = "https://jsonplaceholder.typicode.com/posts"
}
