//
//  Offer.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class Offer: NSObject {
    
    var productId: String
    var name: String
    var price: String
    var salesman: String
    
    init(productId: String, name: String, price: String, salesman: String) {
        self.productId = productId
        self.name = name
        self.price = price
        self.salesman = salesman
    }
}