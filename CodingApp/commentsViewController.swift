//
//  commentsViewController.swift
//  CodingApp
//
//  Created by Rosa Meijers on 24-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import Foundation
import UIKit

class commentsViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var textLabel: UILabel!
    
    @IBAction func saveButtonParse(sender: AnyObject) {
        
        var newComment = Comment(comment: "test", user: PFUser.currentUser()!)
        
        var parseObject = PFObject(className: "Video")
        
        parseObject["videoName"] = "Mark"
        parseObject["comment"] = newComment
        parseObject.saveInBackgroundWithBlock { (succes, error) in
            
        }
    }
    
}