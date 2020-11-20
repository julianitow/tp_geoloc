//
//  Store.swift
//  TP_geoloc
//
//  Created by Julien Guillan on 18/11/2020.
//

import Foundation
import MapKit

class Store {
    var name: String
    var coordinates: CLLocation
    var products: [GraphicCard]
    
    init(name: String, coordinates: CLLocation, products: [GraphicCard]) {
        self.name = name
        self.coordinates = coordinates
        self.products = products
    }
}
