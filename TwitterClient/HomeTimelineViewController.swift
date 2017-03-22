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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Timeline"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        updateTimeline()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if segue.identifier == "showDetailSegue" {
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.dataSource[selectedIndex]
                
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                destinationController.tweet = selectedTweet
            }
            
        }
    }
    
    func updateTimeline() {
        self.activityIndicator.startAnimating()
        
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.dataSource = tweets ?? [] //nil coalescing
                self.activityIndicator.stopAnimating()
            }
//            API.shared.getOAuthUser(callback: {(user) in
//                OperationQueue.main.addOperation {
//                    print("user location: \(user?.location)")
//                }
//            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? TweetCell {
            cell.tweetText.text = dataSource[indexPath.row].text
        }
        //let currentTweet = dataSource[indexPath.row]
        
        //cell.textLabel?.text = currentTweet.text
        //cell.detailTextLabel?.text = currentTweet.user?.name

        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }


}
