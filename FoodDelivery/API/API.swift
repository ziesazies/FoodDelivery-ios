//
//  API.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 11/08/23.
//

import Foundation
import Moya

let apiProvider: MoyaProvider<API> = MoyaProvider<API>(
    plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
)

enum API {
    case popular
    case mostPopular
    case category
}

extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .popular, .mostPopular:
            return URL(string: "https://x8ki-letl-twmt.n7.xano.io/api:KJs76dnG")!
        case .category:
            return URL(string: "https://x8ki-letl-twmt.n7.xano.io/api:8mC4M4TB")!
        }
    }
    
    var path: String {
        switch self {
        case .category:
            return "/restaurant_category"
        case .popular:
            return "/restaurant/popular"
        case .mostPopular:
            return "/restaurant_category"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular, .mostPopular, .category:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .category:
            return .requestPlain
        case .popular:
            return .requestPlain
        case .mostPopular:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
