//
//  User.swift
//  ios-face-book
//
//  Created by James Chen on 16/10/25.
//
import UIKit

struct UserList: Decodable {
    let users: [User]
}

struct User: Decodable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let age: Int
    let phone: String
    let birthDate: String
    
    var profileImage: UIImage?

    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, email, age, phone, birthDate
    }
}
