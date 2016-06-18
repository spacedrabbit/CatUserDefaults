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
  private var paymentDetails: String = "MC X-3234"
  private var md5: String = ""
  
  internal private (set) var firstName: String = ""
  internal private (set) var lastName: String = ""
  internal private (set) var state: String = ""
  internal private (set) var city: String = ""
  
  internal private (set) var username: String = ""
  internal private (set) var email: String = ""
  internal private (set) var profileImage: String = ""
  internal private (set) var phone: String = ""
  
  internal private (set) var following: [UserModel] = []
  internal private (set) var followers: [UserModel] = []
  
  private init() {
  }
  
  convenience init?(withJSON json: [String : AnyObject]) {
    self.init()
    
    guard let nameInfo: [String : AnyObject] = json["name"] as? [String : AnyObject],
      let locationInfo: [String : AnyObject] = json["location"] as? [String : AnyObject],
      let loginInfo: [String: AnyObject] = json["login"] as? [String : AnyObject],
      let emailInfo: String = json["email"] as? String,
      let cellInfo: String = json["phone"] as? String,
      let idInfo: [String : AnyObject] = json["id"] as? [String : AnyObject],
      let pictureInfo: [String : AnyObject] = json["picture"] as? [String : AnyObject] else {
        return
    }
    // contact
    self.email = emailInfo
    self.phone = cellInfo
    
    // name
    guard let fName: String = nameInfo["first"] as? String,
      let lName: String = nameInfo ["last"] as? String else {
        return
    }
    self.firstName = fName
    self.lastName = lName
    
    // location
    guard let stateInfo: String = locationInfo["state"] as? String,
      let cityInfo: String = locationInfo["city"] as? String else {
        return
    }
    self.state = stateInfo
    self.city = cityInfo
    
    // login details 
    guard let user: String = loginInfo["username"] as? String,
      let userMd5: String = loginInfo["md5"] as? String else {
        return
    }
    self.username = user
    self.md5 = userMd5

    // userId
    guard let id: String = idInfo["value"] as? String else {
      return
    }
    self.userId = id
    
    guard let photoLarge: String = pictureInfo["large"] as? String else { return }
    self.profileImage = NSString(string: photoLarge).lastPathComponent // "XX.jpg"
  }
  
  internal func jsonRepresentation() -> [String : AnyObject] {
    return [
      "name" : [ "first" : firstName, "last" : lastName ],
      "location" : [ "state" : state, "city" : city],
      "email" : email,
      "phone" : phone,
      "login" : [ "id" : userId, "md5" : md5],
      "picture" : profileImage,
      "payment" : paymentDetails,
      "following" : following,
      "followers" : followers
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
    defaults.setObject(saveData, forKey: "userData_" + self.userId)
    
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