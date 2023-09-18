//
//  FDAnnotation.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 23/08/23.
//

import Foundation
import MapKit

class FDAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
