//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Nate nanda on 2/12/16.
//  Copyright © 2016 aptification. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tweets: [Tweet]?

    
    
    
    @IBOutlet weak var tweetTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimeLineWithParam(nil) { (tweets, error) -> () in
            print("Tweets are being loadeddd")
            self.tweets = tweets
            self.tweetTableView.reloadData()
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tweets?.count)
        if let tweets = self.tweets {
            return tweets.count;
        }
        return 0;
        //return (tweets?.count)!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        cell.tweet = tweets![indexPath.row]
        
        
        return cell
        
    }



    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
