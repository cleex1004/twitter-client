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
        didSet {
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
            //print(screenName)
            getFeed(screenName)
        }
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil) 
        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == TweetDetailViewController.identifier {
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.dataSource[selectedIndex]
                
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                destinationController.tweet = selectedTweet
            }
            
        }
    }
    
    func getFeed(_ screenName: String) {
        self.activityIndicator.startAnimating()
        API.shared.getTweetsFor(screenName) { (tweets) in
            OperationQueue.main.addOperation {
                self.dataSource = tweets ?? []
                self.activityIndicator.stopAnimating()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: nil)
    }
}
