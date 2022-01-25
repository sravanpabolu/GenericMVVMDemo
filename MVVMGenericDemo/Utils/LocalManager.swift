//
//  LocalManager.swift
//  MVVMGenericDemo
//
//  Created by Sravan on 21/01/22.
//

import Foundation

private extension EndPoint {
    func getLocalUrl() -> URL? {
        switch self {
        case .users:
            return Bundle.main.url(forResource: "Users", withExtension: "json")
        case .posts:
            return Bundle.main.url(forResource: "Posts", withExtension: "json")
        }
    }
    
    func getLocalErrorUrl() -> URL? {
        switch self {
        case .users:
            return Bundle.main.url(forResource: "ErrUsers", withExtension: "json")
        case .posts:
            return Bundle.main.url(forResource: "ErrPosts", withExtension: "json")
        }
    }
}

class LocalManager: HTTPService {
    
    private let isValidURL: Bool
    
    init(isValidURL: Bool) {
        self.isValidURL = isValidURL
    }
    
    func getData<T: Codable>(endPoint: EndPoint, type: T.Type, completion: @escaping (T?, NetworkError?) -> Void ) {
        print("Printing from local json")
        
        let urlStr = isValidURL ? endPoint.getLocalUrl() : endPoint.getLocalErrorUrl()
        
        guard let url = urlStr else {
            completion(nil, NetworkError.urlError)
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            completion(parsedData, nil)
        } catch {
            completion(nil, NetworkError.customError(description: error.localizedDescription))
        }
    }
}
