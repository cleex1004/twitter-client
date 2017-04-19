//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/22/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user : User!

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userLocationLabel: UILabel!
    
    @IBOutlet weak var userScreenNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }
    
    func getUser() {
        API.shared.getUserInfo { (user) in
            OperationQueue.main.addOperation {
                self.user = user
                print(self.user)
                UIImage.fetchImageWidth((self.user?.profileImageURL)!, callback: { (image) in
                    self.profileImage.image = image
                })
                self.userNameLabel.text = "Name: \(user!.name)"
                self.userScreenNameLabel.text = "ScreenName: \(user!.screenName)"
                if user!.location != "" {
                    self.userLocationLabel.text = "Location: \(user!.location)"
                } else {
                    self.userLocationLabel.text = "Location: Unknown"
                }
            }
        }
        
    }

}



