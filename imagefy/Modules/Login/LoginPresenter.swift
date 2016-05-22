//
//  LoginPresenter.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    var interactor: LoginInteractorInputProtocol?
    var wireframe: LoginWireframeProtocol?
    var view: LoginViewProtocol?
    
    func didClickFacebookLoginButton(viewController: UIViewController) {
        interactor?.login(viewController)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didLogin(userId: String) {
        self.view?.showAlert("Ops!", description: "Login error. Try Again!")
    }
    
    func didFail(loginError: LoginError) {
        
    }
}
