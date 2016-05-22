//
//  LoginViewController.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {

    var presenter: LoginPresenterProtocol?
    
    @IBOutlet var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginConfigurator.configure(self)
        
        logo.image = UIImage(named: "ic_logo")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        logo.tintColor = kSecondaryTextColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnLoginFacebookClick(sender: AnyObject) {
        presenter?.didClickFacebookLoginButton(self)
    }
    
    func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loginSuccess(user: User) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.setupInitialView()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
