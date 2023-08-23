//
//  RestaurantCategory.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 13/08/23.
//

import Foundation

struct RestaurantCategory: Decodable {
    let id: Int
    let name: String
    let image: Image?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        image = try container.decodeIfPresent(Image.self, forKey: .image)
    }
}
