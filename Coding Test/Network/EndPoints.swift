//
//  EndPoints.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import Foundation
import Alamofire

enum EndPoints: APIRouter {
    
    case user(page: Int, resultsPerPage: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        
        switch self {
        
        case .user:
            return .get
        }
    }
    
    // MARK: - Parameters
    var parameters: Data? {
        
        switch self {
        
        case .user:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .user(let page, let resultsPerPage):
            return "/api?page=\(page)&results=\(resultsPerPage)"
        }
    }
    
    var timeout: TimeInterval {
        return 20
    }
    
    
    var contentType: String {
        return "application/json; charset=UTF-8"
    }
}
