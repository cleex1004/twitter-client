//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/20/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource = [Tweet]() {
        didSet { //property observer
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Timeline"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        updateTimeline()
        
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil) //nil is same as bundle.main
        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //getUser()
//        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
//            if(success){
//                guard let tweets = tweets else { fatalError("Tweets came back nil") }
//                Tweets.shared.removeAll()
//                for tweet in tweets {
//                    print(tweet.text)
//                    Tweets.shared.add(tweet: tweet)
//                }
//            dataSource = Tweets.shared.allTweets
//            }
//        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        updateTimeline()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == TweetDetailViewController.identifier {
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.dataSource[selectedIndex]
                
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                destinationController.tweet = selectedTweet
            }
            
        }
        
        if segue.identifier == "showProfileSegue" {
            guard segue.destination is ProfileViewController else { return }
            //guard let destinationController = segue.destination as? ProfileViewController else { return }
        }
        
    }
    
    func updateTimeline() {
        self.activityIndicator.startAnimating()
        
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.dataSource = tweets ?? [] //nil coalescing
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
        
//        if let cell = cell as? TweetCell {
//            cell.tweetText.text = dataSource[indexPath.row].text
//        }
        //let currentTweet = dataSource[indexPath.row]
        
        //cell.textLabel?.text = currentTweet.text
        //cell.detailTextLabel?.text = currentTweet.user?.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: nil)
    }
}
