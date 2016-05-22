//
//  WishCreationConfigurator.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishCreationConfigurator: NSObject {
    static func configure(view: WishCreationViewProtocol) {
        let presenter = WishCreationPresenter()
        let interactor = WishCreationInteractor()
        let wireframe = WishCreationWireframe()
        let service = WishCreationService()
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service
        presenter.interactor = interactor
        presenter.view = view
        presenter.wireframe = wireframe
        service.output = interactor
    }
}
