//
//  User.swift
//  Coding Test
//
//  Created by Memo on 3/26/21.
//

import Foundation

struct UserResponse: Decodable {
    var results: [User]
    var info: Info
}

struct Info: Codable {
    var page: Int
    var results: Int
}

struct User: Decodable {
    var gender: String
    var name: UserName
    var email: String
    var phone: String
    var cell: String
    var picture: Picture
    var nat: String
    var location: Location
    
    var fullName: String {
        "\(name.title). \(name.first) \(name.last)"
    }
}

struct UserName: Decodable {
    var title: String
    var first: String
    var last: String
}

struct Location: Decodable {
    var street: Street
    var coordinates: Coordinates
    var city: String
    var state: String
    var country: String
    
    var fullAddress: String {
        "\(street.fullStreet), \(city), \(state), \(country)."
    }
}

struct Street: Decodable {
    var number: Int
    var name: String
    
    var fullStreet: String {
        "\(name) \(number)"
    }
}

struct Coordinates: Decodable {
    var latitude: String
    var longitude: String
}

struct Picture: Decodable {
    var large: String
    var medium: String
    var thumbnail: String
}
