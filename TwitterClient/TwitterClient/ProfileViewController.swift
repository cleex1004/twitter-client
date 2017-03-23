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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("this kinda works")
        getUser()
    }
    
    func getUser() {
        API.shared.getUserInfo { (user) in
            OperationQueue.main.addOperation {
                self.user = user
                self.userNameLabel.text = user?.name
                self.userLocationLabel.text = user?.location
            }
        }
        
    }

}
