//
//  AlmostThereModelView.swift
//  imagefy
//
//  Created by Alan on 5/22/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import Foundation

class AlmostThereModelView: NSObject {
    var productImage: UIImage?
    var brief: String = ""
    var priceValue: Float = 0.0
    
    init(productImage: UIImage?, brief: String, priceValue: Float) {
        super.init()
        
        self.productImage = productImage
        self.brief = brief
        self.priceValue = priceValue
    }
}