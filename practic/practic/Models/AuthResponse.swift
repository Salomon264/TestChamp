//
//  AuthResponse.swift
//  practic
//
//  Created by Alik on 1/29/26.
//

import Foundation

struct AuthResponse: Codable {
    let token: String
    let record: User
    
    enum CodingKeys: String, CodingKey {
        case token, record
    }
}
