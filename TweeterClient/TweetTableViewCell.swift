//
//  tweetTableViewCell.swift
//  Twitter
//
//  Created by Nate nanda on 2/13/16.
//  Copyright © 2016 aptification. All rights reserved.
//

import UIKit
import AFNetworking

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
   
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweetFaved: Bool!
    var reTweeted: Bool!
    
    var tweetId: String?
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var favCountLabel: UILabel!
    
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            userNameLabel.text = tweet.user?.name
            tweetTextLabel.text = tweet.text
            timeStampLabel.text = tweet.createdAtString
            let imageUrlString = (tweet.user?.profileImageUrl)!.stringByReplacingOccurrencesOfString("_normal", withString: "")
            let imageUrl = NSURL(string: imageUrlString)
            print(imageUrl)
            profileImageView.setImageWithURL(imageUrl!)
            tweetId = tweet.tweetId
            favCountLabel.text = tweet.favouriteCount.description
            
            retweetCountLabel.text = tweet.retweetCount.description
            
            tweetFaved = tweet.favorited
            reTweeted = tweet.retweeted
            favButton.selected = tweet.favorited
            retweetButton.selected = tweet.retweeted

            
        
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        // Initialization code
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
        
        
        
        
    }
    
    override func layoutSubviews() {
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
        

    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onFav(sender: AnyObject) {
        TwitterClient.sharedInstance.favTweet(tweet.tweetId!)
        tweet.favouriteCount = tweet.favouriteCount + 1
        favCountLabel.text = tweet.favouriteCount.description
        favButton.selected = true
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.reTweet(tweet.tweetId!)
        retweetButton.selected = true
        tweet.retweetCount  = tweet.retweetCount + 1
        retweetCountLabel.text = tweet.retweetCount.description
        
    }
    
    
    

}
