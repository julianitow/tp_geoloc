//
//  StoreFactory.swift
//  TP_geoloc
//
//  Created by Julien Guillan on 18/11/2020.
//

import Foundation
import MapKit

class StoreFactory {
    static func storeFrom(dictionnary: [String: Any]) -> Store? {
        
        guard let name = dictionnary["name"] as? String else {
            return nil
        }

        guard let location = dictionnary["location"] as? [String: Double] else {
            return nil
        }
        let coordinates = CLLocation(latitude: location["lat"]!, longitude: location["lon"]!)
        
        guard let productsDict = dictionnary["products"] as? [[String: Any]] else {
            return nil
        }
        
        var products: [GraphicCard] = []
        for productDict in productsDict {
            guard let product = ProductFactory.productFrom(dictionnary: productDict) else {
                return nil
            }
            products.append(product)
        }
        
        return Store(name: name, coordinates: coordinates, products: products)
    }
}
