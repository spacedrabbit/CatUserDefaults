//
//  ProfileCardDetailsSection.swift
//  CatUserDefaults
//
//  Created by Louis Tur on 6/17/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit

class ProfileCardDetailsSection: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  // MARK: - Layout
  internal func configureConstraints() {
    
    self.profileHiddenView.snp_makeConstraints { (make) in
      make.top.left.equalTo(self).offset(16.0)
      make.bottom.right.equalTo(self).inset(16.0)
    }
    
    self.lockIconImageView.snp_makeConstraints { (make) in
      make.top.greaterThanOrEqualTo(profileHiddenView).offset(16.0).priority(990.0)
      make.centerX.equalTo(profileHiddenView)
      make.size.equalTo(CGSizeMake(20.0, 20.0))
    }
    
    self.hiddenAccountLabel.snp_makeConstraints { (make) in
      make.top.equalTo(lockIconImageView.snp_bottom).offset(8.0).priorityRequired()
      make.bottom.lessThanOrEqualTo(profileHiddenView).offset(-16.0).priority(980.0)
      make.left.right.equalTo(profileHiddenView)
      make.centerX.equalTo(lockIconImageView)
    }
  }
  
  internal func setupViewHierarchy() {
    self.backgroundColor = FollowButtonColors.OffWhite  
    
    self.addSubview(profileHiddenView)
    self.profileHiddenView.addSubview(lockIconImageView)
    self.profileHiddenView.addSubview(hiddenAccountLabel)
  }
  
  // MARK: - Actions
  internal func shouldShowContent(showContent: Bool) {
    if showContent == true {
      self.profileHiddenView.alpha = 1.0
      UIView.animateWithDuration(0.30, animations: { 
        self.profileHiddenView.alpha = 0.0
      })
    }
    else {
      self.profileHiddenView.alpha = 1.0
    }
  }
  
  // MARK: - Lazy Instances
  internal lazy var profileHiddenView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.redColor()
    return view
  }()
  
  internal lazy var lockIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "lock_icon"))
    imageView.contentMode = .ScaleAspectFit
    imageView.tintColor = UIColor.whiteColor()
    imageView.tintAdjustmentMode = .Normal
    return imageView
  }()
  
  internal lazy var hiddenAccountLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(14.0, weight: UIFontWeightUltraLight)
    label.textColor = UIColor.grayColor()
    label.text = "P R O F I L E  I S  H I D D E N"
    label.textAlignment = .Center
    return label
  }()
}
