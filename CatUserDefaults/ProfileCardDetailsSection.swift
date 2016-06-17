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
  
  private var accountIsHidden: Bool = true {
    willSet {
      if newValue == true {
        self.scrollingContent.alpha = 0.0
        self.profileHiddenView.alpha = 1.0
      } else {
        self.scrollingContent.alpha = 1.0
        self.profileHiddenView.alpha = 0.0
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    self.accountIsHidden = true
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
    
    self.scrollingContent.snp_makeConstraints { (make) in
      make.edges.equalTo(self).offset(EdgeInsetsMake(16.0, left: 8.0, bottom: -8.0, right: -8.0))
    }
  }
  
  internal func setupViewHierarchy() {
    self.backgroundColor = FollowButtonColors.OffWhite
    
    self.addSubview(profileHiddenView)
    self.addSubview(scrollingContent)
    
    self.profileHiddenView.addSubview(lockIconImageView)
    self.profileHiddenView.addSubview(hiddenAccountLabel)
  }
  
  // MARK: - Actions
  internal func shouldShowContent(showContent: Bool) {
    if showContent == true {
      UIView.animateWithDuration(0.30, animations: {
        self.accountIsHidden = false
      })
    }
    else {
      UIView.animateWithDuration(0.30, animations: {
        self.accountIsHidden = true
      })
    }
  }
  
  // MARK: - Lazy Instances
  // profile hidden
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
  
  // content view
  internal lazy var scrollingContent: UIScrollView = {
    let scrollView: UIScrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.alwaysBounceHorizontal = false
    scrollView.backgroundColor = UIColor.greenColor()
    return scrollView
  }()
  
  // TODO: add collection view of followers/following
  
}
