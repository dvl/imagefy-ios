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
            
            let size:CGFloat = 65
            
            self.button.frame = CGRectMake(0.0, win.frame.size.height - 55, size + 10.0, size)
            self.button.layer.cornerRadius = size/2
            self.button.layer.masksToBounds = true
            self.button.backgroundColor = kAccentColor
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
        
        
        let alert = UIAlertController(title: "What is the picture source?", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Take a picture", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            self.selectPhoto(false)
            
        }))
        alert.addAction(UIAlertAction(title: "Select a picture in galery row", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            self.selectPhoto(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    func selectPhoto(isPhotoLibrary: Bool) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = isPhotoLibrary ? .PhotoLibrary : .Camera
        self.presentViewController(picker, animated: true, completion: nil)
    }
}

extension TabbarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerEditedImage]
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
