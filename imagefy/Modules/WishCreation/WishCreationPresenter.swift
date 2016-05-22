//
//  WishCreationPresenter.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishCreationPresenter: WishCreationPresenterProtocol {
    var interactor: WishCreationInteractorInputProtocol?
    var wireframe: WishCreationWireframeProtocol?
    var view: WishCreationViewProtocol?
    
    func sendWish(image: UIImage, description: String, price: Double) {
        let wish = Wish(image: image, description: description, price: price)
        interactor?.createWish(wish)
    }
}

extension WishCreationPresenter: WishCreationInteractorOutputProtocol {
    func didCreateWish(wish: Wish) {
        view?.wishCreationSuccess(wish)
    }
    
    func didFail() {
        view?.showAlert("Fail", description: "Unknow server error. Try again :)")
    }
}