//
//  WishListPresenter.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishListPresenter: WishListPresenterProtocol {
    
    var interactor: WishListInteractorInputProtocol?
    var wireframe: WishListWireframeProtocol?
    var view: WishListViewProtocol?
    
    func getWishes() {
        interactor?.getWishes()
    }
}

extension WishListPresenter: WishListInteractorOutputProtocol {
    func didFail() {
        view?.showAlert("Fail", description: "An error ocurred. Try again.")
    }
    
    func didGetWishes(wishes: [Wish]) {
        view?.didGetWishes(wishes)
    }
}