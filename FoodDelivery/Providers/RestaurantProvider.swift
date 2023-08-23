//
//  RestaurantProvider.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 11/08/23.
//

import Foundation
import RxSwift

class RestaurantProvider {
    
    static fileprivate let shared: RestaurantProvider = RestaurantProvider()
    
    private init() {}
    
    private let disposeBag = DisposeBag()
    
    func getPopular(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        apiProvider.rx.request(.popular)
            .map([Restaurant].self)
            .subscribe { (event) in
                switch event {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getMostPopular(completion: @escaping (Result<[Any], Error>) -> Void) {
        apiProvider.rx.request(.mostPopular)
            .map([Restaurant].self)
            .subscribe { (event) in
                switch event {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            .disposed(by: disposeBag)
    }

    
    func getCategories(completion: @escaping (Result<[RestaurantCategory], Error>) -> Void) {
        
        //MARK: Request with RxMoya
        apiProvider.rx.request(.category)
            .map([RestaurantCategory].self)
            .subscribe { (event) in
                switch event {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }.disposed(by: disposeBag)
        
        //MARK: Request with only Moya
        //        apiProvider.request(.category) { result in
        //            switch result {
        //            case .success(let response):
        //                let data = response.data
        //                let decoder = JSONDecoder()
        //                let categories = try? decoder.decode([RestaurantCategory].self, from: data)
        //                completion(.success(categories ?? []))
        //
        //            case .failure(let error):
        //                completion(.failure(error))
        //
        //            }
        //        }
    }
}

protocol RestaurantProviderProtocol { }
extension RestaurantProviderProtocol {
    var restaurantProvider: RestaurantProvider {
        return RestaurantProvider.shared
    }
}
