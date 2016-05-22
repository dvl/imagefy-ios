//
//  LoginInteractor.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginInteractor: LoginInteractorInputProtocol, LoginInteractorOutputProtocol {
    
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
    
    func didLogin(userId: String, token: String, key: String) {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
            if (error == nil){
                
                let dict = result as! NSDictionary
                let profileImageUrl = dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
                let name = dict.objectForKey("name") as! String
                let email = dict.objectForKey("email") as! String
                let lastName = dict.objectForKey("last_name") as! String
                let firstName = dict.objectForKey("first_name") as! String
                
                let user = User(name: name, email: email, firstName: firstName, lastName: lastName, imageUrl: profileImageUrl)
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                delegate.loggedUser = user
                
                self.presenter?.didLogin(userId, token: token, key: key)
            }
        })
    }
    
    func didFail(loginError: LoginError) {
        
    }
}