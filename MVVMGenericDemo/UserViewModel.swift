//
//  UserViewModel.swift
//  MVVMGenericDemo
//
//  Created by Sravan on 21/01/22.
//

import Foundation

class UserViewModel {
    private var service: HTTPService
    var completion: (() -> Void)?
    var users: [User]?
    var errorString: String?
    
    init(service: HTTPService = NetworkManager()) {
        self.service = service
    }
    
    func getUsers() {
        service.getData(endPoint: .users, type: [User].self) { [weak self] (users, error) in
            guard let self = self else { return }
            
            if let error = error {
                switch error {
                case .customError(let description) :
                    self.errorString = " Custom Error: \(description)"
                    
                case .responseError, .urlError:
                    self.errorString = error.description()
                }
            }
            self.users = users
            self.completion?()
        }
    }
}
