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
    
    var output: LoginServiceOutputProtocol?
    
    private let path = "auth/"
    private let pathFacebookLogin = "auth/facebook/"
    private let pathUser = "auth/user/"
    private let service = BaseService()
    static let sharedInstance = LoginService()
    
    func login(userId: String, accessToken: String) {
        let parameters: [String: AnyObject] = ["access_token": accessToken , "code": userId]
        service.post(self.pathFacebookLogin, parameters: parameters) { (json, error) in
            if let _json = json {
                let key = _json["key"].stringValue
                self.output?.didLogin(accessToken, userId: userId, key: key)
                NSUserDefaults.standardUserDefaults().setValue(key, forKey: "TokenKey")
            } else {
                self.output?.didFail(.UnknowError)
                NSUserDefaults.standardUserDefaults().removeObjectForKey("TokenKey")
            }
        }
    }
    
    func user(key: String) {
        service.get(pathUser) { (json, error) in
            
        }
    }
}
