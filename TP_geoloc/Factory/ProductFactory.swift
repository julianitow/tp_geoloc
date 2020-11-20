//
//  ProductFactory.swift
//  TP_geoloc
//
//  Created by Julien Guillan on 18/11/2020.
//

import Foundation

class ProductFactory {
    
    static func productFrom(dictionnary: [String: Any]) -> GraphicCard? {
        guard let name = dictionnary["name"] as? String,
              let image = dictionnary["image"] as? String,
              let price = dictionnary["price"] as? Double,
              let stock = dictionnary["stock"] as? Int else {
            return nil
        }
        return GraphicCard(name: name, image: image, price: price, stock: stock)
    }
}
