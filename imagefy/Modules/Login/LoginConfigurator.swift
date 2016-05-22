//
//  LoginConfigurator.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class LoginConfigurator: NSObject {
    static func configure(view: LoginViewProtocol) {
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let wireframe = LoginWireframe()
        let service = LoginService()
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        service.output = interactor
    }
}
