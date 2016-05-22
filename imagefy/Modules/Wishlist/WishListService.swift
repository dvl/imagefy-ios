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
                    
                    for (_, offers):(String, JSON) in subJson["offers"] {
                        
                    }
                    
                    let wish = Wish(description: brief, price: price)
                    wish.imageUrl = image
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
