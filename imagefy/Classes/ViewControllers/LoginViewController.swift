//
//  LoginViewController.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func btnLoginFacebookClick(sender: AnyObject) {
        let login = FBSDKLoginManager()
        login.logInWithReadPermissions(["public_profile", "email", "user_birthday", "user_hometown", "user_about_me", "user_photos"], fromViewController: self) { (result, error) in
            guard error == nil else {
                return
            }
            
            if result.isCancelled {
                
            }
            
            if((FBSDKAccessToken.currentAccessToken()) != nil){
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                    if (error == nil){
                        let dict = result as! NSDictionary
                        print(result)
                        print(dict)
                        NSLog(dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                    }
                })
            }
            
            
        }
    }
}
