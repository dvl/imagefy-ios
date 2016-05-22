//
//  LoginService.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginService: LoginServiceProtocol {
    
    var interactor: LoginInteractorOutputProtocol?
    
    private let path = "auth/"
    private let pathFacebookLogin = "auth/facebook"
    private let service = BaseService()
    static let sharedInstance = LoginService()
    
    func login(userId: String, accessToken: String) {
        let parameters: [String: AnyObject] = ["access_token": accessToken , "code": userId ]
        service.post(self.pathFacebookLogin, parameters: parameters) { (json, error) in
            
            self.interactor?.didFail(.UnknowError)
            self.interactor?.didLogin(userId)
            
        }
    }
}
