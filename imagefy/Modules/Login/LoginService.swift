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
                NSUserDefaults.standardUserDefaults().setValue(key, forKey: "TokenKey")
                self.user(key)
            } else {
                self.output?.didFail(.UnknowError)
                NSUserDefaults.standardUserDefaults().removeObjectForKey("TokenKey")
            }
        }
    }
    
    func user(key: String) {
        service.get(self.pathUser) { (json, error) in
            if let _json = json {
                let firstName = _json["first_name"].stringValue
                let lastName = _json["last_name"].stringValue
                let email = _json["email"].stringValue
                let imageUrl = _json["profile"]["avatar_url"].stringValue
                
                let user = User(name: "\(firstName) \(lastName)", email: email, firstName: firstName, lastName: lastName, imageUrl: imageUrl)
                
                self.output?.didLogin(user)
            } else {
                self.output?.didFail(.UnknowError)
                NSUserDefaults.standardUserDefaults().removeObjectForKey("TokenKey")
            }
        }
    }
}
