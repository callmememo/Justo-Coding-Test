//
//  RestAPI.swift
//  Coding Test
//
//  Created by Memo on 3/26/21.
//

import Foundation
import Alamofire

class RestAPI {
    
    private class func performRequest<T: Decodable>(route: APIRouter, decoder: Alamofire.DataDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>)-> Void) {
        do {
            _ = AF.request(try route.request()).validate().responseDecodable(of: T.self) { responseDecodable in
                switch responseDecodable.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}

extension RestAPI {
    
    class func fetchUsers(page: Int = 1, resultsPerPage: Int = 1, completion: @escaping (Result<UserResponse, Error>)-> Void) {
        performRequest(route: EndPoints.user(page: page, resultsPerPage: resultsPerPage), completion: completion)
    }
}
