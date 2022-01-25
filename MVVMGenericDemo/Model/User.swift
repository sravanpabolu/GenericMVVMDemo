//
//  User.swift
//  MVVMGenericDemo
//
//  Created by Sravan on 21/01/22.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
    }
}
