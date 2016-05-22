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
    @IBOutlet weak var lblSalesman: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupWithProductId(productId: String, price: String) {
        myAppDelegate.client.getProductById(productId) { (product, error) in
            self.imgOffer.loadResourceImageWithUrl(product.images[0].src, placeholder: nil)
            self.lblProductName.text = product.title
            self.lblProductPrice.text = "U$ \(price)"
            self.lblSalesman.text = product.vendor
        }
    }
}
