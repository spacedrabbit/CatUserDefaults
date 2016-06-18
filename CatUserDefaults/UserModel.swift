//
//  UserModel.swift
//  CatUserDefaults
//
//  Created by Louis Tur on 6/17/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import Locksmith

extension UserModel: Equatable {}
func ==(lhs: UserModel, rhs: UserModel) -> Bool {
  return lhs.userId == rhs.userId
}

internal class UserModel {
  
  private var userId: String = ""
  private var paymentDetails: String = ""
  internal private (set) var firstName: String = ""
  internal private (set) var lastName: String = ""
  internal private (set) var username: String = ""
  internal private (set) var following: [UserModel] = []
  internal private (set) var followers: [UserModel] = []
  internal private (set) var email: String = ""
  
  private init() {
  }
  
  convenience init?(withJSON json: [String : AnyObject]) {
    self.init()
    
    guard let fName: String = json[" "] as? String,
      let lName: String = json[" "] as? String,
    let uName: String = json[" "] as? String,
    let emailAdd: String = json[" "] as? String,
    let id: String = json[" "] as? String,
    let payment: String = json[" "] as? String else {
      return
    }
    
    self.firstName = fName
    self.lastName = lName
    self.userId = id
    self.username = uName
    self.email = emailAdd
    self.paymentDetails = payment
  }
  
  internal func addFollower(user: UserModel) -> [UserModel] {
    self.followers.append(user)
    return self.followers
  }
  
  internal func removeFollower(user: UserModel) -> [UserModel] {
    if let userIndex = self.followers.indexOf(user) {
      self.followers.removeAtIndex(userIndex)
    }
    return self.followers
  }
  
  
  internal func followUser(user: UserModel) -> [UserModel] {
    self.following.append(user)
    return self.following
  }
  
  internal func unfollowUser(user: UserModel) -> [UserModel] {
    if let userIndex = self.following.indexOf(user) {
      self.following.removeAtIndex(userIndex)
    }
    return self.following
  }
  
}