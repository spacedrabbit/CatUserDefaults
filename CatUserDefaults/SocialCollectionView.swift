//
//  SocialCollectionView.swift
//  CatUserDefaults
//
//  Created by Louis Tur on 6/17/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

class SocialCollectionView: UICollectionView {
  internal static let SocialReuseIdentifier: String = "socialCollectionViewIdentifier"
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    self.setCollectionViewLayout(flowLayout, animated: false)
    self.registerClass(SocialCollectionViewCell.self, forCellWithReuseIdentifier: SocialCollectionView.SocialReuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  
  internal var flowLayout: UICollectionViewFlowLayout = {
    let flow: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    flow.scrollDirection = .Vertical
    flow.minimumInteritemSpacing = 4.0
    flow.estimatedItemSize = CGSizeMake(150, 150)
    flow.sectionInset = UIEdgeInsetsMake(8.0, 0.0, -24.0, 0.0)
    flow.sectionHeadersPinToVisibleBounds = true
    return flow
  }()
}


class SocialCollectionViewController: UICollectionViewController {
  
  
  
}


class SocialCollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let imageSideLength: CGFloat = self.profileIconImageView.frame.size.width
    self.profileIconImageView.layer.cornerRadius = imageSideLength / 2.0
  }
  
  internal func configureConstraints() {
    self.alignmentView.snp_makeConstraints { (make) in
      make.center.equalTo(contentView)
      make.left.equalTo(self.contentView).offset(8.0)
      make.right.equalTo(self.contentView).inset(8.0)
    }
    
    self.profileIconImageView.snp_makeConstraints { (make) in
      make.top.equalTo(alignmentView).offset(8.0)
      make.centerX.equalTo(alignmentView)
      make.width.height.equalTo(48.0)
    }
    
    self.usernameLabel.snp_makeConstraints { (make) in
      make.top.equalTo(profileIconImageView).offset(6.0)
      make.width.centerX.equalTo(alignmentView)
      make.bottom.equalTo(alignmentView).inset(8.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.contentView.addSubview(alignmentView)
    self.alignmentView.addSubview(profileIconImageView)
    self.alignmentView.addSubview(usernameLabel)
  }
  
  internal lazy var profileIconImageView: UIImageView = {
    let imageView: UIImageView = UIImageView()
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()
  
  internal lazy var usernameLabel: UILabel = {
  let label: UILabel = UILabel()
  return label
  }()
  
  internal lazy var alignmentView: UIView = {
  let view: UIView = UIView()
  return view
  }()
}