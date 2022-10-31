//
//  Fruit.swift
//  BusyShop
//
//  Created by Mike Kihiu on 27/10/2022.
//

import Foundation

struct ScannedFruit {
    var count: Int
    var price: Float
    var image: String
    var name: String?
}

extension ScannedFruit {
    
    var totalPrice: Float {
        Float(count) * price
    }
}
