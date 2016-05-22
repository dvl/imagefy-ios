//
//  AlmostThereView.swift
//  imagefy
//
//  Created by Alan on 5/22/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class AlmostThereView: UIView {
    
    let kMaxValue: Float = 2000.0
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var contentViewImage: UIView!
    @IBOutlet weak var priceSlide: UISlider!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var briefText: UITextField!
    
    var price: Float = 0.0
    
    weak var delegate: AlmostThereViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func loadFromNib() -> AlmostThereView {
        let view = NSBundle.mainBundle().loadNibNamed("AlmostThereView", owner: self, options: nil).first as! AlmostThereView
        
        let internalBorder = CALayer()
        internalBorder.frame = CGRectMake(view.productImage.frame.origin.x-2, view.productImage.frame.origin.y-2, view.productImage.frame.size.width+4, view.productImage.frame.size.height+4)
        internalBorder.borderColor = kAccentColor.CGColor
        internalBorder.borderWidth = 2.0
        internalBorder.cornerRadius = (view.productImage.frame.size.height+4)/2
        view.contentViewImage.layer.addSublayer(internalBorder)
        
        return view
    }
    
    class func loadFromNib(productImage: UIImage) -> AlmostThereView {
        let view = NSBundle.mainBundle().loadNibNamed("AlmostThereView", owner: self, options: nil).first as! AlmostThereView
        
        view.productImage.image = productImage
        
        let internalBorder = CALayer()
        internalBorder.frame = CGRectMake(view.productImage.frame.origin.x-2, view.productImage.frame.origin.y-2, view.productImage.frame.size.width+4, view.productImage.frame.size.height+4)
        internalBorder.borderColor = kAccentColor.CGColor
        internalBorder.borderWidth = 2.0
        internalBorder.cornerRadius = (view.productImage.frame.size.height+4)/2
        view.contentViewImage.layer.addSublayer(internalBorder)
        
        return view
    }
    
    @IBAction func slidePrice(sender: UISlider) {
        self.price = priceSlide.value * self.kMaxValue
        
        self.priceLabel.text = "U$ \(Int(self.price)),00"
    }
    
    @IBAction func slidePriceChanged(sender: AnyObject) {
    }
    
    @IBAction func okAction(sender: UIButton) {
        self.removeFromSuperview()
        
        if let d = self.delegate {
            let model = AlmostThereModelView(productImage: self.productImage.image, brief: self.briefText.text ?? "", priceValue: self.price)
            
            d.setupSuccess(model)
        }
    }
}
