//
//  WishListConfigurator.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishListConfigurator: NSObject {
    static func configure(view: WishListViewProtocol) {
        let interactor = WishListInteractor()
        let presenter = WishListPresenter()
        let wireframe = WishListWireframe()
        let service = WishListService()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        presenter.view = view
        interactor.service = service
        interactor.presenter = presenter
        service.output = interactor
        
    }
}
