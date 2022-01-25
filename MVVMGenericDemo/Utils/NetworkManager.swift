//
//  NetworkManager.swift
//  MVVMGenericDemo
//
//  Created by Sravan on 21/01/22.
//

import Foundation

protocol HTTPService{
    func getData<T: Codable>(endPoint: EndPoint, type: T.Type, completion: @escaping (T?, NetworkError?) -> Void )
}

class NetworkManager: HTTPService {
    func getData<T: Codable>(endPoint: EndPoint, type: T.Type, completion: @escaping (T?, NetworkError?) -> Void ) {
        guard let url = URL(string: endPoint.getUrl()) else {
            completion(nil, NetworkError.urlError)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil, NetworkError.responseError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(nil, NetworkError.responseError)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.responseError)
                return
            }
            
            do {
                let users = try JSONDecoder().decode(T.self, from: data)
                completion(users, nil)
            } catch {
                let someError = NetworkError.customError(description: error.localizedDescription)
                completion(nil, someError)
            }
        }.resume()
    }
}
