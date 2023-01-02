//
//  FD.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 30/12/22.
//

import Foundation

class FDObservable<T> {
    var value: T {
        didSet {
            listeners.forEach {$0(value)}
        }
    }
    
    private var listeners: [(T) -> Void] = []
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
