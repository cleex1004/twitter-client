//
//  API.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/21/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import Foundation
import Accounts
import Social

typealias AccountCallback = (ACAccount?) -> () //might need to be plural for lab
typealias UserCallback = (User?) -> ()
typealias TweetsCallback = ([Tweet]?) -> ()

class API {
    static let shared = API()
    
    var account : ACAccount?
    
    private func login(callback: @escaping AccountCallback) { //can escape scope-@escaping-to pass data back
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                callback(nil)
                return
            }
            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount { //casting to let as ACAccount type
                    callback(account)
                }
            } else {
                print("The user did not allow access to their account")
                callback(nil)
            }
        }
    }
    
    private func getOAuthUser(callback: @escaping UserCallback) {
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            request.account = self.account
            request.perform(handler: { (data, response, error) in
                if let error = error {
                    print ("Error: \(error.localizedDescription)")
                    callback(nil)
                    return
                }
                guard let response = response else { callback(nil); return }
                guard let data = data else { callback(nil); return }
                
                switch response.statusCode {
                case 200...299:
                    if let userJSON = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] { //try! refactor to do-try-catch for lab
                        let user = User(json: userJSON)
                        callback(user)
                    } //abstract it out for lab
                default:
                    print("Error: response came back with statusCode: \(response.statusCode)")
                    callback(nil)
                }
            })
        }
    }
    
    private func updateTimeLine(callback: @escaping TweetsCallback) { //callback can escape scope, for async network request, need to be escaping
        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            request.account = self.account
            request.perform(handler: { (data, response, error) in
                if let error = error {
                    print("Error: Error requesting user's home timeline - \(error.localizedDescription)")
                    callback(nil)
                    return
                }
                guard let response = response else { callback(nil); return } //; means line break, same as below
//                guard let response = response else {
//                    callback(nil)
//                    return
//                }
                guard let data = data else { callback(nil); return }
                
                if response.statusCode >= 200 && response.statusCode < 300 { //same as switch above
                    JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                        if success {
                            callback(tweets)
                        }
                    })
                } else {
                    print("Something else went terribly wrong! We have a status code outside 200-299.")
                    callback(nil)
                }
            })
        }
    }
    
    func getTweets(callback: @escaping TweetsCallback) {
        if self.account == nil {
            login(callback: { (account) in //self.login is implicit
                if let account = account {
                    self.account = account
                    self.updateTimeLine(callback: { (tweets) in
                        callback(tweets)
                    })
                }
            })
            
        } else {
            self.updateTimeLine(callback: { (tweets) in
                callback(tweets)
            })
//            self.updateTimeLine(callback: callback) //same as line above
        }
    }
}

































