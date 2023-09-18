//
//  LoginViewModel.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 05/04/23.
//

import Foundation
import FirebaseAuth
import CryptoKit
import AuthenticationServices

class LoginViewModel {
    let email: FDObservable<String?>
    let password: FDObservable<String?>
    
    let isLoading: FDObservable<Bool> = FDObservable<Bool>(false)
    var loadingMessage: String?
    
    let error: FDObservable<Error?> = FDObservable<Error?>(nil)
    let isLoginSuccess: FDObservable<Bool> = FDObservable<Bool>(false)
    
    fileprivate var currentNonce: String?
    var nonce: String {
        let nonce = randomNonceString()
        currentNonce = nonce
        return sha256(nonce)
        
    }
    
    init(email: String? = nil, password: String? = nil) {
        self.email = FDObservable<String?>(email)
        self.password = FDObservable<String?>(password)
    }
    
    func loginWithEmail() {
        loadingMessage = "Please wait..."
        isLoading.value = true
        
        userProvider.login(email: email.value ?? "", password: password.value ?? "") { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success:
                self.userProvider.loadMe { [weak self] (result) in
                    guard let `self` = self else { return }
                    self.isLoading.value = false
                    self.isLoginSuccess.value = true
                }
            case .failure(let error):
                self.isLoading.value = false
                self.error.value = error
            }
        }
    }
    
    func login() {
        loadingMessage = "Please wait..."
        isLoading.value = true
        
        Auth.auth().signIn(withEmail: email.value ?? "", password: password.value ?? "") { [weak self] (result, error) in
            guard let `self` = self else { return }
            self.isLoading.value = false
            
            if let error = error {
                self.error.value = error
                print(error)
            }
            else {
                self.isLoginSuccess.value = true
            }
        }
        
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
        //            self.loadingMessage = "Load your profile"
        //            self.isLoading.value = true
        //
        //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
        //                self.isLoading.value = false
        //                self.isLoginSuccess.value = true
        //            }
        //        }
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func loginWithCredential(_ appleIDCredential: ASAuthorizationAppleIDCredential) {
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        // Initialize a Firebase credential, including the user's full name.
        let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                       rawNonce: nonce,
                                                       fullName: appleIDCredential.fullName)
        
        loadingMessage = "Please wait..."
        isLoading.value = true
        
        // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                self.isLoading.value = false
                self.error.value = error
                return
            }
            
            print("User is signed in to Firebase with Apple.")
            self.isLoading.value = false
            self.isLoginSuccess.value = true
            
        }
    }
}

//MARK: - UserProviderProtocol
extension LoginViewModel: UserProviderProtocol {
    
}
