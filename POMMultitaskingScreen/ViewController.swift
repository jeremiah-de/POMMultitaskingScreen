//
//  ViewController.swift
//  POMMultitaskingScreen
//
//  Created by Jeremiah Gage on 1/22/15.
//  Copyright (c) 2015 Jeremiah Gage. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let POMAppCount = 20
    var isMovingPage:Bool = false
    
    @IBOutlet var screenshotsCollectionView:UICollectionView!
    @IBOutlet var iconsCollectionView:UICollectionView!
    @IBOutlet var pageControl:UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let screenSize = UIScreen.mainScreen().bounds

        let screenshotsCollectionViewFlowLayout = screenshotsCollectionView.collectionViewLayout as UICollectionViewFlowLayout
        screenshotsCollectionViewFlowLayout.itemSize = CGSizeMake(screenSize.width / 2.0, screenSize.height / 2.0)
        screenshotsCollectionViewFlowLayout.minimumInteritemSpacing = 0.0
        screenshotsCollectionViewFlowLayout.minimumLineSpacing = -150.0
        let screenshotsSectionInset = screenSize.width / 4.0
        screenshotsCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0.0, screenshotsSectionInset, 0.0, screenshotsSectionInset)

        let iconsCollectionViewFlowLayout = iconsCollectionView.collectionViewLayout as UICollectionViewFlowLayout
        let iconHeight = iconsCollectionView.frame.height - 30.0
        iconsCollectionViewFlowLayout.itemSize = CGSizeMake(iconHeight, iconHeight)
        iconsCollectionViewFlowLayout.minimumInteritemSpacing = 0.0
        iconsCollectionViewFlowLayout.minimumLineSpacing = -50.0
        let iconsSectionInset = screenshotsSectionInset + (screenshotsCollectionViewFlowLayout.itemSize.width - iconsCollectionViewFlowLayout.itemSize.width) / 2.0
        iconsCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0.0, iconsSectionInset, 0.0, iconsSectionInset)
        
        pageControl.numberOfPages = POMAppCount
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return POMAppCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell
        
        let hue = CGFloat(indexPath.item) / CGFloat(POMAppCount)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)

        if (collectionView == screenshotsCollectionView) {
            let screenshotCell = collectionView.dequeueReusableCellWithReuseIdentifier("ScreenshotCell", forIndexPath: indexPath) as ScreenshotCollectionViewCell
            screenshotCell.color = color
            screenshotCell.layer.shadowColor = UIColor.blackColor().CGColor
            screenshotCell.layer.shadowRadius = 20.0
            screenshotCell.layer.shadowOpacity = 1.0
            screenshotCell.layer.shadowOffset = CGSizeZero
            screenshotCell.layer.masksToBounds = false
            screenshotCell.layer.shouldRasterize = true
            cell = screenshotCell
        }
        else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("IconCell", forIndexPath: indexPath) as UICollectionViewCell
            cell.backgroundColor = color
            cell.layer.cornerRadius = 20.0
            cell.layer.masksToBounds = true
            cell.layer.borderWidth = 5.0
            cell.layer.borderColor = UIColor.blackColor().CGColor
        }
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let screenshotsCollectionViewFlowLayout = screenshotsCollectionView.collectionViewLayout as UICollectionViewFlowLayout
        let iconsCollectionViewFlowLayout = iconsCollectionView.collectionViewLayout as UICollectionViewFlowLayout
        let screenshotsDistanceBetweenItemsCenter = screenshotsCollectionViewFlowLayout.minimumLineSpacing + screenshotsCollectionViewFlowLayout.itemSize.width
        let iconsDistanceBetweenItemsCenter = iconsCollectionViewFlowLayout.minimumLineSpacing + iconsCollectionViewFlowLayout.itemSize.width
        let offsetFactor = screenshotsDistanceBetweenItemsCenter / iconsDistanceBetweenItemsCenter

        if (scrollView == screenshotsCollectionView) {
            let xOffset = scrollView.contentOffset.x - scrollView.frame.origin.x
            iconsCollectionView.contentOffset.x = xOffset / offsetFactor
        }
        else if (scrollView == iconsCollectionView) {
            let xOffset = scrollView.contentOffset.x - scrollView.frame.origin.x
            screenshotsCollectionView.contentOffset.x = xOffset * offsetFactor
        }

        let pageWidth = screenshotsDistanceBetweenItemsCenter
        let currentPage = Int((screenshotsCollectionView.contentOffset.x + pageWidth / 2.0) / pageWidth)
        
        if (!isMovingPage) {
            pageControl.currentPage = currentPage
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView)
    {
        isMovingPage = false
    }
    
    @IBAction func changePage(sender: UIPageControl)
    {
        let screenshotsCollectionViewFlowLayout = screenshotsCollectionView.collectionViewLayout as UICollectionViewFlowLayout
        let screenshotsDistanceBetweenItemsCenter = screenshotsCollectionViewFlowLayout.minimumLineSpacing + screenshotsCollectionViewFlowLayout.itemSize.width
        var frame = screenshotsCollectionView.frame
        frame.origin.x = screenshotsDistanceBetweenItemsCenter * CGFloat(pageControl.currentPage)
        isMovingPage = true
        screenshotsCollectionView.scrollRectToVisible(frame, animated: true)
    }
}

