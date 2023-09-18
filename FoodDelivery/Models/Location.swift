//
//  Location.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 16/09/23.
//

import Foundation
import MapKit

struct Location: Codable {
    let type: String = "point"
    let data: Point
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(Point.self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(data, forKey: .data
        )
    }
}
