//
//  Image.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 13/08/23.
//

import Foundation

struct Image: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}
