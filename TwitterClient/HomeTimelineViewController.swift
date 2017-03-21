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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
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
    func updateTimeline() {
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.dataSource = tweets ?? [] //nil coalescing
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentTweet = dataSource[indexPath.row]
        
        cell.textLabel?.text = currentTweet.text
        cell.detailTextLabel?.text = currentTweet.user?.name

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }


}
