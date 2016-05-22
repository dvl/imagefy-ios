//
//  WishListInteractor.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishListInteractor: WishListInteractorInputProtocol {
    var presenter: WishListInteractorOutputProtocol?
    var service: WishListServiceProtocol?
    
    func getWishes() {
        service?.getWishes()
    }
}

extension WishListInteractor: WishListServiceOutputProtocol {
    func didGetWishes(wishes: [Wish]) {
        presenter?.didGetWishes(wishes)
    }
    
    func didFail(error: WishListError) {
        presenter?.didFail()
    }
}
