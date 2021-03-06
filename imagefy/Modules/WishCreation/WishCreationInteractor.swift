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
        service?.createWish(wish)
    }
}

extension WishCreationInteractor: WishCreationServiceOutputProtocol {
    func didCreateWish(wish: Wish) {
        self.presenter?.didCreateWish(wish)
    }
    
    func didFail(error: WishCreationError) {
        self.presenter?.didFail()
    }
}
