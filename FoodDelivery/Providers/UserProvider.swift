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
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        
        let user = UserData.fetchUserData(context: context)
        self.user.value = user
    }
    
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
    
    private func updateUserData(_ user: User) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        
        _ = UserData.saveUserData(user, context: context)
        appDelegate.saveContext()
        
    }
    
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
                    self.updateUserData(user)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }.disposed(by: disposeBag)
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        authAPIProvider.rx.request(.profileImage(image, user.value?.id ?? 0))
            .map(User.self)
            .subscribe { (event) in
                switch event {
                case .success(let user):
                    self.user.value = user
                    self.updateUserData(user)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            .disposed(by: disposeBag)
    }
}

protocol UserProviderProtocol { }
extension UserProviderProtocol {
    var userProvider: UserProvider {
        return UserProvider.shared
    }
}
