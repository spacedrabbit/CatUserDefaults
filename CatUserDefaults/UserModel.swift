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
    
    guard let userInfo: [String : AnyObject] = json["user"] as? [String : AnyObject] else {
      return
    }
    
    guard let fName: String = userInfo["firstName"] as? String,
      let lName: String = userInfo["lastName"] as? String,
      let uName: String = userInfo["username"] as? String,
      let emailAdd: String = userInfo["email"] as? String,
      let id: String = userInfo["userId"] as? String,
      let payment: String = userInfo["paymentDetails"] as? String else {
        return
    }
    
    self.firstName = fName
    self.lastName = lName
    self.userId = id
    self.username = uName
    self.email = emailAdd
    self.paymentDetails = payment
  }
  
  private func jsonRepresentation() -> [String : AnyObject] {
    return [ "user" :
      [ "firstName" : firstName,
        "lastName" : lastName,
        "email" : email,
        "paymentDetails" : paymentDetails,
        "username" : username,
        "userId" : userId,
        "following" : following,
        "followers" : followers
      ]
    ]
  }
  
  
  // follower actions
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
  
  
  // following actions
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
  
  
  // MARK: - Persistance
  internal func saveUserToDefaults() {
    let defaults = NSUserDefaults.standardUserDefaults()
    // TODO: try other NSData encoding options
    let saveData: NSData = NSKeyedArchiver.archivedDataWithRootObject(self.jsonRepresentation())
    defaults.setObject(saveData, forKey: "userData")
    
    defaults.synchronize() // TOOD: test
  }
  
  internal class func loadUserFromDefaults() -> UserModel? {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if let userData: NSData = defaults.objectForKey("userData") as? NSData {
      if let userJson: [String : AnyObject] = NSKeyedUnarchiver.unarchiveObjectWithData(userData) as? [String : AnyObject] {
        if let restoredUser: UserModel = UserModel(withJSON: userJson) {
          return restoredUser
        }
      }
    }
    return nil
  }
  
  
  // MARK: - Locksmith Persistance
  // TODO: this
}