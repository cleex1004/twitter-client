//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/22/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    var tweet : Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.tweet.user?.name ?? "Unknown") //nil coalescing
        print(self.tweet.text)
        print(self.tweet.retweet)
        //do stuff in lab
        
        self.userLabel.text = self.tweet.user?.name ?? "Unknown"
        self.tweetLabel.text = self.tweet.text
        self.retweetLabel.text = "This tweet has been retweeted \(self.tweet.retweet) times"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == ViewFeedViewController.identifier {
            guard let destinationController = segue.destination as? ViewFeedViewController else { return }
            destinationController.tweet = self.tweet
        }
        
    }
}
