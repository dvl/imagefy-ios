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
    
    func getUserByKey(key: String) {
        interactor?.getUserByKey(key)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func didLogin(user: User) {
        self.view?.loginSuccess(user)
    }
    
    func didFail(loginError: LoginError) {
        self.view?.showAlert("Ops!", description: "Login error. Try Again!")
    }
}
