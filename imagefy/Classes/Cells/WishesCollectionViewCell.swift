//
//  WishesCollectionViewCell.swift
//  imagefy
//
//  Created by Alan Magalhães Lira on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var content: UIView!
    @IBOutlet weak var lblProductBrief: UILabel!
    @IBOutlet weak var lblOffersCount: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupViewCell(urlImage: String, frameWidth: CGFloat) {
        UIDesign.viewShadowPath(self.content.layer, bounds: self.content.bounds, radius: 3.5, shadowOffset: CGSize(width: 4, height: 4), masksToBounds: true)
        UIDesign.viewShadowPath(self.layer, bounds: self.bounds, radius: 3.5, shadowOffset: CGSize(width: 1, height: 4), masksToBounds: false)
        let otherSubContent = UIImageView()
        otherSubContent.contentMode = .ScaleAspectFill
        otherSubContent.clipsToBounds = true
        otherSubContent.loadResourceImageWithUrl(urlImage, placeholder: nil)
        let height:CGFloat = frameWidth * 0.42
        
        otherSubContent.frame = CGRectMake(0, 0, frameWidth, height)
        self.content.addSubview(otherSubContent)
        self.content.sendSubviewToBack(otherSubContent)
    }
}
