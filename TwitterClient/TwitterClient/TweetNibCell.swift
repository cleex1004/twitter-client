//
//  TweetNibCell.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/23/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class TweetNibCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            self.userNameLabel.text = tweet.user?.name ?? "Unknown User"
            
            if let user = tweet.user {
                UIImage.fetchImageWidth(user.profileImageURL) { (image) in
                    self.userImageView.image = image
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
