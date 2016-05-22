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
        
        let data = UIImageJPEGRepresentation(wish.image, 0.5)
        let dataString = data?.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        let parameters: [String: AnyObject] = ["buget": wish.price, "brief": wish.productDescription, "photo": dataString!]
        
        service.post(path, parameters: parameters) { (json, error) in
            guard error == nil else {
                self.output?.didFail(.ServerError)
                return
            }
        }
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
