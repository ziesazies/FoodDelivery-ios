//
//  LoginViewModel.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 05/04/23.
//

import Foundation

class LoginViewModel {
    let email: FDObservable<String?>
    let password: FDObservable<String?>
    
    let isLoading: FDObservable<Bool> = FDObservable<Bool>(false)
    var loadingMessage: String?
    
    let error: FDObservable<Error?> = FDObservable<Error?>(nil)
    let isLoginSuccess: FDObservable<Bool> = FDObservable<Bool>(false)
    
    init(email: String? = nil, password: String? = nil) {
        self.email = FDObservable<String?>(email)
        self.password = FDObservable<String?>(password)
    }
    
    func login() {
        loadingMessage = "Please wait..."
        isLoading.value = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.loadingMessage = "Load your profile"
            self.isLoading.value = true
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.isLoading.value = false
                self.isLoginSuccess.value = true
            }
        }
    }
}
