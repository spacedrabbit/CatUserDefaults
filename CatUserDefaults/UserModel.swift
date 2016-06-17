//
//  UserModel.swift
//  CatUserDefaults
//
//  Created by Louis Tur on 6/17/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import Locksmith

internal class UserModel {
  
  private var userId: String = ""
  private var paymentDetails: String = ""
  internal private (set) var firstName: String = ""
  internal private (set) var lastName: String = ""
  internal private (set) var username: String = ""
  internal private (set) var following: [UserModel]?
  internal private (set) var followers: [UserModel]?
  internal private (set) var email: String = ""
  
  private init() {
  }
  
  convenience init(withJSON: [String : AnyObject]) {
    self.init()
    
    
    
  }
  
  
  
}