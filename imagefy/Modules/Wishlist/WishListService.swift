//
//  WishListService.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import SwiftyJSON

class WishListService: WishListServiceProtocol {
    
    var output: WishListServiceOutputProtocol?
    
    private let path = "wishes/"
    private let service = BaseService()
    
    func getWishes() {
        service.get(self.path) { (json, error) in
            if let _json = json {
                
                var wishes: [Wish] = []
                
                for (_, subJson):(String, JSON) in _json {
                    let image = subJson["photo"].stringValue
                    let brief = subJson["brief"].stringValue
                    let price = subJson["buget"].stringValue
                    
                    var offers: [Offer] = []
                    
                    for (_, offersJson):(String, JSON) in subJson["offers"] {
                        let productId = offersJson["shopify_product_id"].stringValue
                        let offer = Offer()
                        offer.productId = productId
                        offers.append(offer)
                    }
                    
                    let wish = Wish(description: brief, price: price)
                    wish.imageUrl = image
                    wish.offers = offers
                    
                    wishes.append(wish)
                }
                
                self.output?.didGetWishes(wishes)
            } else {
                self.output?.didFail(.UnknowError)
                NSUserDefaults.standardUserDefaults().removeObjectForKey("TokenKey")
            }
        }
    }
}
