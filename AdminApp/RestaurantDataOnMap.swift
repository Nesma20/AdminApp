//
//  RestaurantDataOnMap.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/21/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import MapKit
class RestaurantDataOnMap : NSObject , MKAnnotation{

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var city :String?
    init(title: String, city: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.city = city
        self.coordinate = coordinate
        
        super.init()
    }

}
