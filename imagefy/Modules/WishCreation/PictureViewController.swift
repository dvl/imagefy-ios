//
//  PictureViewController.swift
//  imagefy
//
//  Created by Alan on 5/22/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import pop
import AssetsLibrary
import RNActivityView

enum CameraSourceType: Int {
    case Camera = 0, Galery
}

class PictureViewController: UIViewController, WishCreationViewProtocol {

    var presenter: WishCreationPresenterProtocol?
    var pictureTaked: UIImage!
    let picker = UIImagePickerController()
    
    @IBOutlet var cameraContentView: UIView!
    @IBOutlet var cameraAcessory: UIView!
    @IBOutlet var cameraButton: UIButton!
    
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
        WishCreationConfigurator.configure(self)
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
    
    
    // MARK: - WishCreationViewProtocol
    func wishCreationSuccess(wish: Wish) {
        self.dismissViewControllerAnimated(true, completion: nil)
        myAppDelegate.window!.showActivityViewWithLabel("Wish recorded  ;)")
        myAppDelegate.window!.hideActivityViewWithAfterDelay(1)
    }
    
    func showAlert(title: String, description: String) {
        self.view.showActivityViewWithLabel("An error ocurred. Please, try again.")
        self.view.hideActivityViewWithAfterDelay(2)
    }
    
    func wishCreationAlert(image: UIImage) {
        
        let almostAlert = AlmostThereView.loadFromNib(image)
        almostAlert.frame = CGRectMake(self.view.frame.origin.x - 4, self.view.frame.origin.y - 72, self.view.frame.width + 8, self.view.frame.height + 72)
        
        almostAlert.delegate = self
        
        self.navigationController?.view.addSubview(almostAlert)
        
        let spring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        spring.velocity = NSValue(CGPoint: CGPointMake(8, 8))
        spring.springBounciness = 20
        almostAlert.pop_addAnimation(spring, forKey: "size")
        
    }
}

extension PictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.pictureTaked = chosenImage
            
            self.wishCreationAlert(chosenImage)
            
        } else if let imageUrl = info[UIImagePickerControllerReferenceURL] as? NSURL{
            let assetLibrary = ALAssetsLibrary()
            assetLibrary.assetForURL(imageUrl , resultBlock: { (asset: ALAsset!) -> Void in
                if let actualAsset = asset as ALAsset? {
                    let assetRep: ALAssetRepresentation = actualAsset.defaultRepresentation()
                    let iref = assetRep.fullResolutionImage().takeUnretainedValue()
                    let image = UIImage(CGImage: iref)
                    
                    self.pictureTaked = image
                    
                    self.wishCreationAlert(image)
                }
                }, failureBlock: { (error) -> Void in
            })
        }
    }
}

extension PictureViewController: AlmostThereViewDelegate {
    func setupSuccess(model: AlmostThereModelView) {
        self.view.showActivityViewWithLabel("")
        print("Model - brief: \(model.brief) - value: \(model.priceValue) - image: \(model.productImage)")
        presenter?.sendWish(model.productImage!, description: model.brief, price: Double(model.priceValue))
    }
}