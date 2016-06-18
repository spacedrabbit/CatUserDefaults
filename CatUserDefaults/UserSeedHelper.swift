//
//  UserSeedHelper.swift
//  CatUserDefaults
//
//  Created by Louis Tur on 6/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation

internal class UserSeedHelper {
  
  internal class func loadUserSeedData() {
    
    if let path = NSBundle.mainBundle().pathForResource("random_users", ofType: "json") {
      if let jsonData = NSData(contentsOfFile: path) {
        
        do {
          
          if let jsonResults = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? NSDictionary {
            if let results: [[String : AnyObject]] = jsonResults["results"] as? [[String : AnyObject]] {
              
              for result in results {
                if let newUser: UserModel = UserModel(withJSON: result) {
                  print("\n\n\nUser: \(newUser.jsonRepresentation())")
                  newUser.saveUserToDefaults()
                }
              }
              
            }
          }
        }
        catch {
          print("Loading JSON data threw")
        }
          
        
      }
    }
    
    
  }
  
}