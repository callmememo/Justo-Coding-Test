//
//  APIRouter.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import Foundation
import Alamofire

protocol APIRouter {
    var method: HTTPMethod { get}
    var parameters: Data? { get }
    var path: String { get }
    var timeout: TimeInterval { get }
    var contentType: String { get }
}

extension APIRouter {
    
    var baseURL: String {
        return "https://randomuser.me"
    }
    
    private func asURLRequest(_ url: URL) throws -> URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeout)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        // Parameters
        urlRequest.httpBody = parameters
        
        return urlRequest
    }
    
    func request() throws -> URLRequest {
        let urlRequest = baseURL + path
        let escapedUrl = urlRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return try asURLRequest(URL(string: escapedUrl!)!)
    }
}
