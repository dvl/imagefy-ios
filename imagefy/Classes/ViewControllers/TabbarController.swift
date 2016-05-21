//
//  TabbarController.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2.0)), dispatch_get_main_queue(), {
            let button: UIButton = UIButton(type: .Custom)
            let win:UIWindow = UIApplication.sharedApplication().delegate!.window!!
            
            let size:CGFloat = 65
            
            button.frame = CGRectMake(0.0, win.frame.size.height - 55, size, size)
            button.layer.cornerRadius = size/2
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor.redColor()
            button.tintColor = UIColor.whiteColor()
            button.center = CGPoint(x:win.center.x , y: button.center.y)
            button.setImage(UIImage(named: "Camera"), forState: .Normal)
            button.addTarget(self, action: #selector(TabbarController.didTapCameraButton), forControlEvents: .TouchUpInside)
            
            win.addSubview(button)
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapCameraButton() {
        print("Camera button pressed")
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
