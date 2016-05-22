//
//  Wish.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class Wish: NSObject {
    
    var image: UIImage?
    var imageUrl: String?
    var productDescription: String
    var price: String
    var offers: [Offer] = []
    
    init(description: String, price: String) {
        self.productDescription = description
        self.price = price
    }
}
