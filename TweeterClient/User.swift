//
//  User.swift
//  Twitter
//
//  Created by Nate nanda on 2/12/16.
//  Copyright © 2016 aptification. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification =  "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"]as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
    } //end init
    
    func logout() {
            User.currentUser = nil
            TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
            NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }//end logout
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey)as? NSData
            if data != nil {
                var dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
            }
        }
            return _currentUser
        } //end get
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = try! NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
            
        } //end set(user)
    } //end class currentUser

}
