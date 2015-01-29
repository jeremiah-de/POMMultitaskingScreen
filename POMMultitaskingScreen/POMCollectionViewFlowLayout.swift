//
//  POMCollectionViewFlowLayout.swift
//  POMMultitaskingScreen
//
//  Created by Jeremiah Gage on 1/28/15.
//  Copyright (c) 2015 Jeremiah Gage. All rights reserved.
//

import UIKit

class POMCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        var offsetAdjustment = MAXFLOAT;
        var horizontalOffset = proposedContentOffset.x + (self.collectionView!.bounds.size.width - self.itemSize.width) / 2.0
        var targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView!.bounds.size.width, self.collectionView!.bounds.size.height)
        
        var array = super.layoutAttributesForElementsInRect(targetRect)
        
        for layoutAttributes in array! {
            var itemOffset = layoutAttributes.frame.origin.x;
            if (fabsf(Float(itemOffset - horizontalOffset)) < fabsf(offsetAdjustment)) {
                offsetAdjustment = Float(itemOffset - horizontalOffset)
            }
        }
        
        var offsetX = Float(proposedContentOffset.x) + offsetAdjustment
        return CGPointMake(CGFloat(offsetX), proposedContentOffset.y)
    }
}
