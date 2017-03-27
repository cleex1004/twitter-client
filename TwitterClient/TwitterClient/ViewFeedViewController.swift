//
//  ViewFeedViewController.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/23/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ViewFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweet : Tweet!
    
    var dataSource = [Tweet]() {
        didSet { //property observer
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Timeline"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        if let screenName = self.tweet.user?.screenName{
            print(screenName)
            getFeed(screenName)
        }
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil) //nil is same as bundle.main
        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    func getFeed(_ screenName: String) {
        self.activityIndicator.startAnimating()
        API.shared.getTweetsFor(screenName) { (tweets) in
            OperationQueue.main.addOperation {
                self.dataSource = tweets ?? []
                self.activityIndicator.stopAnimating()
                print(self.dataSource)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.dataSource[indexPath.row]
        cell.tweet = tweet
         return cell
    }
}
