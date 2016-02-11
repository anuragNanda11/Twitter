//
//  TweeterClient.swift
//  TweeterClient
//
//  Created by Nate nanda on 2/10/16.
//  Copyright © 2016 aptification. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "4xul2m3XEzBSOXBYagmo9i0oj"
let twitterConsumerSecret = "2mt5Ej0hvrfFrZp1IQskBZMIguuhagcUro2COWYmq64oncPuuE"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient {
        struct Static  {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }

}
