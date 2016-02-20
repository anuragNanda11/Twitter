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
    
    var loginCompletion: ((user: User?, error: NSError?) ->())?
    
    class var sharedInstance: TwitterClient {
        struct Static  {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    } //end class sharedInstance
    
    func homeTimeLineWithParam(params: NSDictionary?, completion: (tweets:[Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Got timeline")
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
            }) { (operation: NSURLSessionDataTask?,error: NSError) -> Void in
                print("erorr getting timeLine")
                print(error.code)
                completion(tweets: nil, error: error)
        }
    }
    
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) ->()) {
        loginCompletion = completion
        
        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(
            "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "cpTwitterDemoAnurag://oauth"),
            scope: nil,
            success: {
                (requestToken: BDBOAuth1Credential!) -> Void in
                print("Got the request token")
                
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                
                UIApplication.sharedApplication().openURL(authURL!)
                
            }) {
                (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
        

    } //end loginWithCompletion
    
    
    func openURL(url: NSURL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user:\(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                print("failed to receive acess token")
        }
        
        
    }//end openURL
    
   
    
    func reTweet(tweetID: String) {
        let request = "1.1/statuses/retweet/\(tweetID).json"
        print (request)
        
        TwitterClient.sharedInstance.POST(request, parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("reTweet successfully")
            print(response)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't reTweeeet the tweet")
        }

        
    }
    
    func favTweet(tweetID: String) {
        let request = "/1.1/favorites/create.json?id=\(tweetID)"
        print (request)
        
        TwitterClient.sharedInstance.POST(request, parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("faved successfully")
            print(response)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't fav the tweet")
        }
    }

}
