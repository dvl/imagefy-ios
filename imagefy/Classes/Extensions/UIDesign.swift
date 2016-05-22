//
//  Visual.swift
//  imagefy
//
//  Created by Alan Magalhães Lira on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

public class UIDesign {
    
    class func viewShadowPath(layer: CALayer, bounds: CGRect, radius: CGFloat, shadowOffset: CGSize, masksToBounds: Bool) {
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 0.4
        layer.cornerRadius = radius
        layer.masksToBounds = masksToBounds
        layer.shadowPath = shadowPath.CGPath
    }
    
    class func viewCornerRadius(layer: CALayer, bounds: CGRect, byRoundingCorners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: byRoundingCorners, cornerRadii: CGSizeMake(radius, radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = path.CGPath
        
        layer.mask = maskLayer
        layer.masksToBounds = true
    }
}