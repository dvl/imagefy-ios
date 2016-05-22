//
//  LoginInteractor.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginInteractor: LoginInteractorInputProtocol, LoginServiceOutputProtocol {
    
    var presenter: LoginInteractorOutputProtocol?
    var service: LoginServiceProtocol?
    
    func login(viewController: UIViewController) {
        let login = FBSDKLoginManager()
        login.logInWithReadPermissions(["public_profile", "email", "user_birthday", "user_hometown", "user_about_me", "user_photos"], fromViewController: viewController) { (result, error) in
            guard error == nil else {
                self.presenter?.didFail(.UnknowError)
                return
            }
            
            if result.isCancelled {
                self.presenter?.didFail(.Cancelled)
            }
            
            if((FBSDKAccessToken.currentAccessToken()) != nil){
                
                let userId = FBSDKAccessToken.currentAccessToken().userID
                let token  = FBSDKAccessToken.currentAccessToken().tokenString
                
                self.service?.login(userId, accessToken: token)
            }
        }
    }
    
    func getUserByKey(key: String) {
        service?.user(key)
    }
    
    func didFail(error: LoginError) {
        
    }
    
    func didLogin(user: User) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.loggedUser = user
        self.presenter?.didLogin(user)
    }
    
}