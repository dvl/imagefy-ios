//
//  WishOffersViewController.swift
//  imagefy
//
//  Created by Guilherme Augusto on 22/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import Buy
import DZNEmptyDataSet

private let reuseIdentifier = "WishesCellIdentifier"

class WishOffersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var offers: [Offer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.collectionView?.emptyDataSetSource = self
        self.collectionView?.emptyDataSetDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! WishOfferCell
        
//        cell.productImage.image = UIImage(named: "accoustic_guitar")
        
        UIDesign.viewShadowPath(cell.layer, bounds: cell.bounds, radius: 3.5, shadowOffset: CGSize(width: 1, height: 4))
//        cell.productImage.layer.cornerRadius = 3.5
//        cell.content.layer.cornerRadius = 3.5
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width:CGFloat = self.view.frame.width * 0.94
        let height:CGFloat = width * 0.6
        
        return CGSizeMake(width, height)
    }
    
    // Margens
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 5, 2, 5)
    }
}

extension WishOffersViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func emptyDataSetDidTapView(scrollView: UIScrollView!) {
        
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "offer")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Imagefy"
        let attributes = [NSFontAttributeName: UIFont(name: "Comfortaa", size: 18)!, NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "We didn't found your product yet"
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .ByWordWrapping
        paragraph.alignment = .Center
        
        let attributes = [NSFontAttributeName: UIFont(name: "Comfortaa", size: 15)!, NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSParagraphStyleAttributeName: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}

