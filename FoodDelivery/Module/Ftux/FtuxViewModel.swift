//
//  FtuxViewModel.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 30/12/22.
//

import Foundation
import UIKit

class FtuxViewModel {
    
    private var ftuxes: [Ftux] = []
    let error: FDObservable<Error?> = FDObservable<Error?>(nil)
    
    let currentIndex: FDObservable<Int> = FDObservable<Int>(-1)
    
    func loadFtuxes() {
        FtuxProvider.shared.loadFtuxes { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let data):
                self.ftuxes = data
                self.currentIndex.value = data.count > 0 ? 0: -1
            case .failure(let error):
                self.error.value = error 
            }
        }
    }
    
    var numberOfItems: Int {
        return ftuxes.count
    }
    
    func imageAtIndex(_ index: Int) -> UIImage? {
        let ftux = ftuxes[index]
        let image = UIImage(named: ftux.image)
        return image
    }
    
    func titleAtIndex(_ index: Int) -> String {
        let ftux = ftuxes[index]
        return ftux.title
    }
    
    func subtitleAtIndex(_ index: Int) -> String {
        let ftux = ftuxes[index]
        return ftux.subtitle
    }
    
    func buttonTitleAtIndex(_ index: Int) -> String {
        return index == ftuxes.count - 1 ? "Let's start" : "Begin"
    }
    
}
