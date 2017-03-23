//
//  Tweet.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/20/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import Foundation

class Tweet {
    let text : String
    let id : String
    let retweet : Int
    
    var user : User?
    
    init?(json: [String: Any]) {
        if let text = json["text"] as? String, let id = json["id_str"] as? String, let retweet = json["retweet_count"] as? Int {
            self.text = text
            self.id = id
            self.retweet = retweet
            if let userDictionary = json["user"] as? [String : Any]{
                self.user = User(json: userDictionary)
            }
        } else {
            return nil
        }
    }
}
