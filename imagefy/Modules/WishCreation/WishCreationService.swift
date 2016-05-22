//
//  WishCreationService.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishCreationService: WishCreationServiceProtocol {
    
    var output: WishCreationServiceOutputProtocol?
    
    private let path = "wishes/"
    private let service = BaseService()
    
    func createWish(wish: Wish) {
        let parameters: [String: AnyObject] = ["buget": Int(wish.price)!, "brief": wish.productDescription]
        
        service.upload(path, image: wish.image!, parameters: parameters) { (json, error) in
            guard error == nil else {
                self.output?.didFail(.ServerError)
                return
            }
            
            self.output?.didCreateWish(wish)
        }
    }
}
