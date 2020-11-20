//
//  GraphicCard.swift
//  TP_geoloc
//
//  Created by Julien Guillan on 18/11/2020.
//

import Foundation

class GraphicCard {
    var name: String
    var image: String
    var price: Double
    var stock: Int
    
    init(name: String, image: String, price: Double, stock: Int) {
        self.name = name
        self.image = image
        self.price = price
        self.stock = stock
    }
}
