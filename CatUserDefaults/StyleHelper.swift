//
//  StyleHelper.swift
//  CatUserDefaults
//
//  Created by Louis Tur on 6/17/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal class StyleHelper {
  
  internal class func drawGradientIn(view: UIView) {
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [FollowButtonColors.LightBlue.CGColor, FollowButtonColors.MediumBlue.CGColor]
    gradientLayer.locations = [0.0, 1.0] // even transition from light blue to medium blue
    gradientLayer.startPoint = CGPointMake(0.0, 0.0) // top-left corner
    gradientLayer.endPoint = CGPointMake(1.0, 1.0) // bottom-right corner
    
    view.layer.addSublayer(gradientLayer)
  }

}