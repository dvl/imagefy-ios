//
//  TabbarController.swift
//  imagefy
//
//  Created by Guilherme Augusto on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import pop

class TabbarController: UITabBarController {

    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2.0)), dispatch_get_main_queue(), {
            self.button = UIButton(type: .Custom)
            let win:UIWindow = UIApplication.sharedApplication().delegate!.window!!
            
            self.button.frame = CGRectMake(0.0, win.frame.size.height - 65, 60, 60)
            self.button.layer.cornerRadius = 60/2
            self.button.layer.masksToBounds = true
            self.button.backgroundColor = UIColor.redColor()
            self.button.tintColor = UIColor.whiteColor()
            self.button.center = CGPoint(x:win.center.x , y: self.button.center.y)
            self.button.setImage(UIImage(named: "Camera"), forState: .Normal)
            self.button.addTarget(self, action: #selector(TabbarController.didTapCameraButton), forControlEvents: .TouchUpInside)
            
            let spring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            spring.velocity = NSValue(CGPoint: CGPointMake(8, 8))
            spring.springBounciness = 20
            
            self.button.pop_addAnimation(spring, forKey: "sendAnimation")
            
            win.addSubview(self.button)
            
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapCameraButton() {
        let spring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        spring.velocity = NSValue(CGPoint: CGPointMake(8, 8))
        spring.springBounciness = 20
        
        self.button.pop_addAnimation(spring, forKey: "sendAnimation")
    }

}
