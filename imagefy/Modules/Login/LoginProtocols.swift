//
//  LoginProtocols.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

public enum LoginError {
    case Cancelled
    case UnknowError
    case UnregisteredUsed
}

protocol LoginInteractorDelegate {
    func onLoginSuccess()
    func onLoginError(error: LoginError)
}

protocol LoginWireframeProtocol : class {
    
}

protocol LoginViewProtocol : class {
    var presenter: LoginPresenterProtocol? { get set }
    func showAlert(title: String, description: String)
    func loginSuccess(user: User)
}

protocol LoginPresenterProtocol : class {
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireframe: LoginWireframeProtocol? { get set }
    
    var view: LoginViewProtocol? { get set }
    
    func didClickFacebookLoginButton(viewController: UIViewController)
    func getUserByKey(key: String)
}

protocol LoginInteractorInputProtocol : class {
    weak var presenter: LoginInteractorOutputProtocol? { get set }
    weak var service: LoginServiceProtocol? { get set }
    func login(viewController: UIViewController)
    func getUserByKey(key: String)
}

protocol LoginInteractorOutputProtocol : class {
    func didLogin(user: User)
    func didFail(loginError: LoginError)
}

protocol LoginServiceProtocol: class {
    weak var output: LoginServiceOutputProtocol? {get set}
    func login(userId: String, accessToken: String)
    func user(key: String)
}

protocol LoginServiceOutputProtocol: class {
    func didLogin(user: User)
    func didFail(error: LoginError)
}