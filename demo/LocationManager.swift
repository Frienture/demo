//
//  LocationManager.swift
//  demo
//
//  Created by macbookpro on 14/11/2021.
//

import Foundation
import CoreLocation

struct Location {
    let title: String
    let coordinates: CLLocationCoordinate2D
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
//    public func findLocations(with query: String, completion: @escaping(([ <#type#> ]) -> Void)) {
//        
//    }
    
}
