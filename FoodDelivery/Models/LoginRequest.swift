//
//  LoginRequest.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 16/09/23.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
}
