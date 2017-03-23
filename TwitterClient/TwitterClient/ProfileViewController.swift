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

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userLocationLabel: UILabel!
    
    @IBOutlet weak var userScreenNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("this kinda works")
        getUser()
    }
    
    func getUser() {
        API.shared.getUserInfo { (user) in
            OperationQueue.main.addOperation {
                self.user = user
                print(self.user)
                self.userNameLabel.text = "The Users Name is: \(user!.name)"
                self.userScreenNameLabel.text = "The Users ScreenName is: \(user!.screenName)"
                if user!.location != "" {
                    self.userLocationLabel.text = "The Users Location is: \(user!.location)"
                } else {
                    self.userLocationLabel.text = "The Users Location is: Unknown"
                }
            }
        }
        
    }

}


