//
//  WishCreationInteractor.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishCreationInteractor: WishCreationInteractorInputProtocol {
    
    var presenter: WishCreationInteractorOutputProtocol?
    var service: WishCreationServiceProtocol?
    
    func createWish(wish: Wish) {
        
    }
}

extension WishCreationInteractor: WishCreationServiceOutputProtocol {
    func didCreateWish(wish: Wish) {
        
    }
    
    func didFail(error: WishCreationError) {
        
    }
}
