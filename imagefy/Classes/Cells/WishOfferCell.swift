//
//  WishOfferCell.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit

class WishOfferCell: UICollectionViewCell {
    
    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
