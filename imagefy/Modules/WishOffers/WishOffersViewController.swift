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
import RNActivityView

private let reuseIdentifier = "WishOfferCell"

class WishOffersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var offers: [Offer] = []
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.collectionView?.emptyDataSetSource = self
        self.collectionView?.emptyDataSetDelegate = self
        self.title = "Offers"
        
        self.refreshControl.tintColor = kAccentColor
        self.refreshControl.addTarget(self, action: #selector(WishOffersViewController.reloadData), forControlEvents: .ValueChanged)
        self.collectionView?.addSubview(self.refreshControl)
        self.collectionView?.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(animated: Bool) {
        let tabbar = self.tabBarController as! TabbarController
        tabbar.showButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData() {
        self.collectionView?.reloadData()
        
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }
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
        
        let offer = offers[indexPath.row]
        cell.setupWithProductId(offer.productId!, price: offer.price ?? "100")
        
        UIDesign.viewShadowPath(cell.layer, bounds: cell.bounds, radius: 3.5, shadowOffset: CGSize(width: 1, height: 4), masksToBounds: true)
        cell.imgOffer.layer.cornerRadius = 3.5
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let offer = offers[indexPath.row]
        self.view.showActivityView()
        myAppDelegate.client.getProductById(offer.productId) { (product, error) in
            let vc = self.productViewController()
            vc.loadWithProduct(product) { (success, error) in
                self.view.hideActivityViewWithAfterDelay(2)
                guard error == nil else {
                    return
                }
                
                if let tabbar = self.tabBarController as? TabbarController {
                    tabbar.hideButton()
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
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
    
    func productViewController() -> BUYProductViewController {
        let theme = BUYTheme()
        theme.style = .Light
        theme.tintColor = kAccentColor
        theme.showsProductImageBackground = true
        return BUYProductViewController(client: myAppDelegate.client, theme: theme)
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
        let text = "We have not found offers for you yet"
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .ByWordWrapping
        paragraph.alignment = .Center
        
        let attributes = [NSFontAttributeName: UIFont(name: "Comfortaa", size: 15)!, NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSParagraphStyleAttributeName: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}

