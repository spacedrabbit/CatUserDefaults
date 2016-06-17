//
//  ProfileCardInfoSection.swift
//  CatUserDefaults
//
//  Created by Louis Tur on 6/17/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

class ProfileCardInfoSection: UIView {
  
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  override func layoutSubviews() {
    // the ordering of this annoyingly matters
    StyleHelper.drawGradientIn(self)
    self.bringSubviewToFront(contentView)
    
    self.profileImageView.clipsToBounds = true
    let largestSide: CGFloat = max(CGRectGetWidth(profileImageView.frame), CGRectGetHeight(profileImageView.frame))
    self.profileImageView.layer.cornerRadius = largestSide / 2.0
  }
  
  // MARK: - Layout
  internal func configureConstraints() {
    self.contentView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.menuIconImageView.snp_makeConstraints { (make) in
      make.size.equalTo(CGSizeMake(20.0, 20.0))
      make.left.top.equalTo(self).offset(16.0)
    }
    
    self.searchIconImageView.snp_makeConstraints { (make) in
      make.size.equalTo(menuIconImageView)
      make.top.equalTo(self).offset(16.0)
      make.right.equalTo(self).offset(-16.0)
      make.bottom.centerY.equalTo(menuIconImageView).priority(980.0)
    }
    
    self.profileImageView.snp_makeConstraints { (make) in
      make.centerX.equalTo(self)
      make.top.equalTo(self.menuIconImageView.snp_bottom).offset(8.0)
      make.size.equalTo(CGSizeMake(72.0, 72.0))
    }
    
    self.usernameLabel.snp_makeConstraints { (make) in
      make.top.equalTo(profileImageView.snp_bottom).offset(12.0)
      make.centerX.equalTo(profileImageView)
      make.width.lessThanOrEqualTo(self)
    }
    
    self.descriptionLabel.snp_makeConstraints { (make) in
      make.top.equalTo(usernameLabel.snp_bottom).offset(4.0)
      make.centerX.equalTo(profileImageView)
      make.width.lessThanOrEqualTo(self)
    }
    
    self.socialIconsAlignmentView.snp_makeConstraints { (make) in
      make.top.equalTo(self.descriptionLabel.snp_bottom).offset(24.0)
      make.centerX.equalTo(self)
      make.width.lessThanOrEqualTo(self)
      make.height.equalTo(20.0)
    }
    
    self.facebookIconImageView.snp_makeConstraints { (make) in
      make.size.equalTo(self.menuIconImageView)
      make.centerY.equalTo(socialIconsAlignmentView)
      make.left.equalTo(socialIconsAlignmentView)
    }
    
    self.twitterIconImageView.snp_makeConstraints { (make) in
      make.size.centerY.equalTo(facebookIconImageView)
      make.left.equalTo(facebookIconImageView.snp_right).offset(18.0)
    }
    
    self.githubIconImageView.snp_makeConstraints { (make) in
      make.size.centerY.equalTo(facebookIconImageView)
      make.left.equalTo(twitterIconImageView.snp_right).offset(18.0)
      make.right.equalTo(socialIconsAlignmentView)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.addSubview(contentView)
    
    self.contentView.addSubview(menuIconImageView)
    self.contentView.addSubview(searchIconImageView)
    self.contentView.addSubview(profileImageView)
    self.contentView.addSubview(usernameLabel)
    self.contentView.addSubview(descriptionLabel)
    self.contentView.addSubview(socialIconsAlignmentView)
    
    self.socialIconsAlignmentView.addSubview(facebookIconImageView)
    self.socialIconsAlignmentView.addSubview(twitterIconImageView)
    self.socialIconsAlignmentView.addSubview(githubIconImageView)
  }
  
  override func tintColorDidChange() {
    print("changed tint color")
  }
  
  // MARK: - Actions
  internal func didTapTwitterIcon(sender: AnyObject?) {
    
  }
  
  internal func didTapFacebookIcon(sender: AnyObject?) {
    
  }
  
  internal func didTapGithubIcon(sender: AnyObject?) {
    
  }
  
  internal func didTapMenuIcon(sender: AnyObject?) {
    
  }
  
  internal func didTapSearchIcon(sender: AnyObject?) {
    
  }
  
  
  // MARK: - Lazy Instances
  internal lazy var contentView: UIView = {
  let view: UIView = UIView()
  return view
  }()
  
  internal lazy var profileImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "avatar_louis"))
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()
  
  internal lazy var searchIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "search_icon"))
    imageView.contentMode = .ScaleAspectFit
    imageView.tintColor = UIColor.whiteColor()
    imageView.tintAdjustmentMode = .Normal
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileCardInfoSection.didTapSearchIcon(_:))))
    return imageView
  }()
  
  internal lazy var menuIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "menu_icon"))
    imageView.contentMode = .ScaleAspectFit
    imageView.tintColor = UIColor.whiteColor()
    imageView.tintAdjustmentMode = .Normal
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileCardInfoSection.didTapMenuIcon(_:))))
    return imageView
  }()
  
  internal lazy var usernameLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(24.0, weight: UIFontWeightSemibold)
    label.textColor = FollowButtonColors.OffWhite
    label.text = "spacedrabbit"
    label.textAlignment = .Center
    return label
  }()
  
  internal lazy var descriptionLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(18.0, weight: UIFontWeightLight)
    label.textColor = FollowButtonColors.OffWhite
    label.text = "iOS Developer / Tinkerer"
    label.textAlignment = .Center
    return label
  }()
  
  // social icons
  internal lazy var socialIconsAlignmentView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  internal lazy var twitterIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "twitter_icon"))
    imageView.contentMode = .ScaleAspectFit
    imageView.tintColor = UIColor.whiteColor()
    imageView.tintAdjustmentMode = .Normal
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileCardInfoSection.didTapTwitterIcon(_:))))
    return imageView
  }()
  
  internal lazy var facebookIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "facebook_icon"))
    imageView.contentMode = .ScaleAspectFit
    imageView.tintColor = UIColor.whiteColor()
    imageView.tintAdjustmentMode = .Normal
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileCardInfoSection.didTapFacebookIcon(_:))))
    return imageView
  }()
  
  internal lazy var githubIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "github_icon"))
    imageView.contentMode = .ScaleAspectFit
    imageView.tintColor = UIColor.whiteColor()
    imageView.tintAdjustmentMode = .Normal
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileCardInfoSection.didTapGithubIcon(_:))))
    return imageView
  }()
}
