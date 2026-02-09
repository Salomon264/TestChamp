//
//  User.swift
//  practic
//
//  Created by Alik on 1/29/26.
//

import Foundation
import Alamofire

struct User: Codable {
    let id: String
    let email: String?
    let password: String?
    let created: String?
    let updated: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email, password, created, updated
    }
}
