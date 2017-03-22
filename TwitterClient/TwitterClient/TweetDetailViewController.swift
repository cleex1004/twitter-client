//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/22/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet : Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.tweet.user?.name ?? "Unknown") //nil coalescing
        print(self.tweet.text)
        //do stuff in lab
    
    }
}
