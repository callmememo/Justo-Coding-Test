//
//  UsersViewModel.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import UIKit

class UsersViewModel {
        
    private var users = [User]()
    private var pageNumber: Int
    
    var resultsPerPage: Int    
    var isWating: Bool
    
    init() {
        resultsPerPage = 20
        isWating = false
        pageNumber = 0
    }
    
    func setup(_ completion: @escaping (Bool) -> Void) {
        
        isWating = true
        pageNumber += 1
        
        RestAPI.fetchUsers(page: pageNumber, resultsPerPage: resultsPerPage) { [weak self] result in
            
            self?.isWating = false
            
            switch result {
            case .success(let response):
                
                self?.users.append(contentsOf: response.results)
                
                completion(true)
                
            case .failure:
                completion(false)
            }
        }
    }
    
    func count() -> Int {
        users.count
    }
    
    func user(at index: Int) -> User {
        users[index]
    }
    
    func change(to resultsPerPage: Int) {
        self.resultsPerPage =  resultsPerPage
        pageNumber = 0
        users.removeAll()
    }
}
