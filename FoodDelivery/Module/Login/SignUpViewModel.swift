//
//  SignUpViewModel.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 05/04/23.
//

import Foundation
import FirebaseAuth

class SignUpViewModel {
    let name: FDObservable<String?> = FDObservable<String?>(nil)
    let email: FDObservable<String?> = FDObservable<String?>(nil)
    let phone: FDObservable<String?> = FDObservable<String?>(nil)
    let address: FDObservable<String?> = FDObservable<String?>(nil)
    let password: FDObservable<String?> = FDObservable<String?>(nil)
    let confirmPassword: FDObservable<String?> = FDObservable<String?>(nil)
    
    let isLoading: FDObservable<Bool> = FDObservable<Bool>(false)
    var loadingMessage: String?
    
    let error: FDObservable<Error?> = FDObservable<Error?>(nil)
    let isSignUpSuccess: FDObservable<Bool> = FDObservable<Bool>(false)
    
    func signUp() {
        guard let name = name.value, name.count >= 3 else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Name is required and must be longer than 3 characters"])
            self.error.value = error
            return
        }
        
        guard let email = email.value, email.isValidEmail else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Email is not valid"])
            self.error.value = error
            return
        }
        
        guard let password = password.value, password.isValidPassword else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Password is not valid"])
            self.error.value = error
            return
        }
        
        guard confirmPassword.value == password else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Confirm password does not match"])
            self.error.value = error
            return
        }
        
        loadingMessage = "Please wait..."
        isLoading.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let `self` = self else { return }
            self.isLoading.value = false
            
            if let error = error {
                self.error.value = error
            }
            else {
                self.isSignUpSuccess.value = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.isLoading.value = false
            self.isSignUpSuccess.value = true
        }
    }
}
