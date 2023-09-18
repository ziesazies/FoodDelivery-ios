//
//  User.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 16/09/23.
//

import Foundation

struct User: Codable {
    let id: Int
    var name: String
    let email: String
    var phone: String
    var address: String
    var location: Location?
    var profileImage: Image?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case address
        case location
        case profileImage = "profile_image"
    }
    
    init(userData: UserData) {
        id = Int(userData.userId)
        name = userData.name ?? ""
        email = userData.email ?? ""
        phone = userData.phone ?? ""
        address = userData.address ?? ""
        profileImage = Image(url: userData.profileImageUrl ?? "")
        if let data = userData.location,
           let location = try? JSONDecoder().decode(Location.self, from: data) {
            self.location = location
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
        location = try container.decodeIfPresent(Location.self, forKey: .location)
        profileImage = try container.decodeIfPresent(Image.self, forKey: .profileImage)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(phone, forKey: .phone)
        try container.encode(address, forKey: .address)
        try container.encode(location, forKey: .location)
    }
}
