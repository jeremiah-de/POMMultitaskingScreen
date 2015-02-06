//
//  ScreenshotCollectionViewCell.swift
//  POMMultitaskingScreen
//
//  Created by Jeremiah Gage on 2/5/15.
//  Copyright (c) 2015 Jeremiah Gage. All rights reserved.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell
{
    var gradientLayer:CAGradientLayer!
    var color:UIColor! {
        didSet {
            if (gradientLayer == nil) {
                gradientLayer = CAGradientLayer()
                gradientLayer.frame = bounds
                self.layer.insertSublayer(gradientLayer, atIndex: 0)
            }
            gradientLayer.colors = [UIColor.blackColor().CGColor, color.CGColor, UIColor.blackColor().CGColor]
        }
    }
}
