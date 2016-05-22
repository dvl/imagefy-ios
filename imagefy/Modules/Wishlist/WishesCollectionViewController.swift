//
//  WishesCollectionViewController.swift
//  imagefy
//
//  Created by Alan Magalhães Lira on 21/05/16.
//  Copyright © 2016 Alan M. Lira. All rights reserved.
//

import UIKit
import Buy
import DZNEmptyDataSet

private let reuseIdentifier = "WishesCellIdentifier"

class WishesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, WishListViewProtocol {

    var wishes: [Wish] = []
    var presenter: WishListPresenterProtocol?
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        
        self.collectionView?.emptyDataSetSource = self
        self.collectionView?.emptyDataSetDelegate = self
        
        self.refreshControl.tintColor = kAccentColor
        self.refreshControl.addTarget(self, action: #selector(WishesCollectionViewController.reloadData), forControlEvents: .ValueChanged)
        self.collectionView?.addSubview(self.refreshControl)
        
        WishListConfigurator.configure(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        presenter?.getWishes()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueOffers" {
            let vc = segue.destinationViewController as! WishOffersViewController
            let wish = sender as! Wish
            
            vc.offers = wish.offers
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! WishesCollectionViewCell
        let wish = wishes[indexPath.row]
        
        cell.setupViewCell(wish.imageUrl!, frameWidth: self.view.frame.width * 0.94)
        cell.lblProductBrief.text = wish.productDescription
        cell.lblOffersCount.text = "\(wish.offers.count) Offers"
        
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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let wish = wishes[indexPath.row]
        self.performSegueWithIdentifier("segueOffers", sender: wish)
    }
    
    func reloadData() {
        presenter?.getWishes()
    }
    
    //MARK: - WishListViewProtocol
    func showAlert(title: String, description: String) {
        
    }
    
    func didGetWishes(wishes: [Wish]) {
        self.wishes = wishes
        self.collectionView?.reloadData()
        
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }
    }
}

extension WishesCollectionViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func emptyDataSetDidTapView(scrollView: UIScrollView!) {
        
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Imagefy"
        let attributes = [NSFontAttributeName: UIFont(name: "Comfortaa", size: 18)!, NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Your wish list is empty!"
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .ByWordWrapping
        paragraph.alignment = .Center
        
        let attributes = [NSFontAttributeName: UIFont(name: "Comfortaa", size: 15)!, NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSParagraphStyleAttributeName: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}
