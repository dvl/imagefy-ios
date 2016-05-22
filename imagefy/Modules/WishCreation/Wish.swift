//
//  Wish.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class Wish: NSObject {
    var image: UIImage
    var productDescription: String
    var price: Double
    
    init(image: UIImage, description: String, price: Double) {
        self.image = image
        self.productDescription = description
        self.price = price
    }
}
