//
//  Tweet.swift
//  Twitter
//
//  Created by Nate nanda on 2/12/16.
//  Copyright © 2016 aptification. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var tweetId: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var timeStamp: String?
    var favorited: Bool!
    var retweeted: Bool!
    var favouriteCount: Int!
    var retweetCount: Int!
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        //print(createdAtString)
        //createdAtString = createdAtString?.stringByReplacingOccurrencesOfString(<#T##target: String##String#>, //withString: //)
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        let dateFormatter = NSDateFormatter()
        //the "M/d/yy, H:mm" is put together from the Symbol Table
        dateFormatter.dateFormat = "M/dd/yy"
        createdAtString = (dateFormatter.stringFromDate(createdAt!))
        
        tweetId = dictionary["id_str"] as! String
        
       favouriteCount =  (dictionary["favorite_count"]) as! Int
        
        retweetCount = (dictionary ["retweet_count"] as! Int)
        
        retweeted = (dictionary ["retweeted"] as! Bool )
        favorited = (dictionary ["favorited"] as! Bool)
        
        print(retweeted)
        
    } //end init
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    } //end tweetsWithArray

}
