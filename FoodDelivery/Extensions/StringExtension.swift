//
//  StringExtension.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 05/04/23.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
}
