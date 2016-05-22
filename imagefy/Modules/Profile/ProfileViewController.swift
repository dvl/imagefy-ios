//
//  ProfileViewController.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let user = appDelegate.loggedUser
        
        imgProfile.loadResourceImageWithUrl(user!.imageUrl, placeholder: UIImage(named: "profilePlaceholder"))
        lblUsername.text = user?.name
        lblEmail.text = user?.email
        
        UIDesign.viewCornerRadius(imgProfile.layer, bounds: imgProfile.bounds, byRoundingCorners: .AllCorners, radius: imgProfile.frame.size.width/2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogoutClick(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("TokenKey")
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.setupInitialView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
