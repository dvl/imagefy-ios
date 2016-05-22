//
//  PictureViewController.swift
//  imagefy
//
//  Created by Alan on 5/22/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import pop

enum CameraSourceType: Int {
    case Camera = 0, Galery
}

class PictureViewController: UIViewController {

    var pictureTaked: UIImage!
    @IBOutlet var cameraContentView: UIView!
    @IBOutlet var cameraAcessory: UIView!
    @IBOutlet var cameraButton: UIButton!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .Camera
        picker.cameraCaptureMode = .Photo
        picker.showsCameraControls = false
        
        let frame = cameraContentView.frame
        
        picker.view.frame = CGRectMake(frame.origin.x, frame.origin.y - 64, frame.width, frame.height + 64)
        picker.view.backgroundColor = UIColor.clearColor()
        picker.cameraOverlayView?.backgroundColor = UIColor.clearColor()
        picker.navigationBarHidden = true
        picker.toolbarHidden = true
        picker.cameraViewTransform = CGAffineTransformMakeScale(1.4, 1.4)
        picker.edgesForExtendedLayout = .None
        cameraContentView.addSubview(picker.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraSegmentationChanged(sender: UISegmentedControl) {
        
        dispatch_async(dispatch_get_main_queue()) { 
            switch CameraSourceType(rawValue: sender.selectedSegmentIndex)! {
            case CameraSourceType.Camera:
                self.picker.sourceType = .Camera
                self.cameraAcessory.hidden = false
                break
            case CameraSourceType.Galery:
                self.picker.sourceType = .SavedPhotosAlbum
                self.cameraAcessory.hidden = true
                break
            }
        }
    }
    
    @IBAction func cameraTakePicture() {
        if self.cameraButton.pop_animationForKey("size") == nil {
            picker.takePicture()
            
            let spring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            spring.velocity = NSValue(CGPoint: CGPointMake(8, 8))
            spring.springBounciness = 20
            self.cameraButton.pop_addAnimation(spring, forKey: "size")
        }
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension PictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerEditedImage]
        
        
//        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}