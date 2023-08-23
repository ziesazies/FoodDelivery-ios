//
//  Restaurant.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 14/08/23.
//

import Foundation

struct Restaurant: Decodable {
    let id: Int
    let name: String
    let description: String
    let overallRating: Double
    let totalRating: Int
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case overallRating = "overall_rating"
        case totalRating = "total_rating"
        case image
        
        enum Image: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        overallRating = try values.decodeIfPresent(Double.self, forKey: .overallRating) ?? 0.0
        totalRating = try values.decodeIfPresent(Int.self, forKey: .totalRating) ?? 0
        
        do {
            let image = try values.nestedContainer(keyedBy: CodingKeys.Image.self, forKey: .image)
            imageUrl = try image.decodeIfPresent(String.self, forKey: .url) ?? ""
        }
        catch {
            imageUrl = ""
        }
    }
    
}
