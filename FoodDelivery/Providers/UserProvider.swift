//
//  UserProvider.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 16/09/23.
//

import Foundation
import RxSwift

class UserProvider {
    static fileprivate let shared: UserProvider = UserProvider()
    private init() { }
    
    let user: FDObservable<User?> = FDObservable<User?>(nil)
    
    private let kAccessTokenKey: String = "\(Bundle.main.bundleIdentifier ?? "").kAccessToken"
#if DEBUG
    var accessToken: String? {
        get {
            return UserDefaults.standard.value(forKey: kAccessTokenKey) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kAccessTokenKey)
            UserDefaults.standard.synchronize()
        }
    }
#else
    // FIXME: Store access token in key chain!
    var accessToken: String? {
        get {
            return UserDefaults.standard.value(forKey: kAccessTokenKey) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kAccessTokenKey)
            UserDefaults.standard.synchronize()
        }
    }
#endif
    
    private let disposeBag = DisposeBag()
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = LoginRequest(email: email, password: password)
        authAPIProvider.rx.request(.login(request))
            .map(String.self, atKeyPath: "authToken")
            .subscribe { (event) in
                switch event {
                case .success(let accessToken):
                    self.accessToken = accessToken
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }.disposed(by: disposeBag)
    }
    
    func loadMe(completion: @escaping (Result<Void, Error>) -> Void) {
        authAPIProvider.rx.request(.me)
            .map(User.self)
            .subscribe { (event) in
                switch event {
                case .success(let user):
                    self.user.value = user
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }.disposed(by: disposeBag)
    }
}

protocol UserProviderProtocol { }
extension UserProviderProtocol {
    var userProvider: UserProvider {
        return UserProvider.shared
    }
}
