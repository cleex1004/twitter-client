//
//  UIExtensions.swift
//  TwitterClient
//
//  Created by Christina Lee on 3/23/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

extension UIImage {
    typealias ImageCallback = (UIImage?) -> ()
    
    class func fetchImageWidth(_ urlString: String, callback: @escaping ImageCallback) {
        OperationQueue().addOperation {
            guard let url = URL(string: urlString) else { callback(nil); return }
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                
                OperationQueue.main.addOperation {
                    callback(image)
                }
            }
        }
    }
}
