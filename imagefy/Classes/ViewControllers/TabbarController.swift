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
        
        let size:CGFloat = 70

        self.button = UIButton(type: .Custom)
        self.button.frame = CGRectMake(0, 0, size + 40.0, size)
        self.button.layer.cornerRadius = size/2
        self.button.layer.masksToBounds = true
        self.button.backgroundColor = kAccentColor
        self.button.tintColor = UIColor.whiteColor()
        self.button.setImage(UIImage(named: "Camera"), forState: .Normal)
        self.button.addTarget(self, action: #selector(TabbarController.didTapCameraButton), forControlEvents: .TouchUpInside)
        let heightDifference: CGFloat = size + 10.0 - self.tabBar.frame.size.height
        if heightDifference < 0 {
            button.center = self.tabBar.center
        }
        else {
            var center: CGPoint = self.tabBar.center
            center.y = center.y - heightDifference / 2.0 + 15.0
            button.center = center
        }
        
        let spring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        spring.velocity = NSValue(CGPoint: CGPointMake(8, 8))
        spring.springBounciness = 20
        spring.repeatForever = true
        spring.autoreverses = true
        
        self.button.pop_addAnimation(spring, forKey: "pop")
        
        self.view!.addSubview(button)
        
        let btn1 = UIButton()
        btn1.setImage(UIImage(named: "logout"), forState: .Normal)
        btn1.frame = CGRectMake(0, 0, 30, 30)
        btn1.addTarget(self, action: #selector(TabbarController.didTapExitButton), forControlEvents: .TouchUpInside)
        self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(customView: btn1), animated: true);
    }
    
    func hideButton() {
        self.button.hidden = true
    }
    
    func showButton() {
        self.button.hidden = false
        let spring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        spring.velocity = NSValue(CGPoint: CGPointMake(8, 8))
        spring.springBounciness = 20
        spring.repeatForever = true
        spring.autoreverses = true
        
        self.button.pop_addAnimation(spring, forKey: "pop")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapExitButton() {
        print("exit")
    }
    
    func didTapCameraButton() {
        
        if self.button.pop_animationForKey("size") == nil {
            
            let spring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            spring.velocity = NSValue(CGPoint: CGPointMake(8, 8))
            spring.springBounciness = 20
            self.button.pop_addAnimation(spring, forKey: "size")
            
            if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("navPictureViewController") {
                
                if let tabBar = myAppDelegate.topViewController() as? TabbarController,
                    let navC = tabBar.selectedViewController as? UINavigationController {
                    navC.presentViewController(vc, animated: true, completion: nil)
                }
            }
        }
    }
}
