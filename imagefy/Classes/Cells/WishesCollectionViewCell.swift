//
//  WishesCollectionViewCell.swift
//  imagefy
//
//  Created by Alan Magalhães Lira on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var content: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
