//
//  categorie1.swift
//  CodingApp
//
//  Created by Rosa Meijers on 14-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

class categorie2VC: UIViewController {
    
    
    @IBOutlet var pfPhoto: PFImageView!
    @IBOutlet var userLabel: UILabel!
    
    @IBOutlet var objCbutton: UIButton!
    @IBOutlet var swiftButton: UIButton!
   
    @IBAction func profielButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profiel = storyboard.instantiateViewControllerWithIdentifier("profielVC")
          navigationController?.pushViewController(profiel, animated: true)
    }
    
    @IBAction func objectiveCButton(sender: AnyObject) {
        objectCParse()
        self.nextViewController()
    }
   
    @IBAction func swiftButton(sender: AnyObject) {
         swiftParse()
         self.nextViewController()
    }
   
    @IBAction func skipThis2(sender: AnyObject) {
         self.nextViewController()
    }
    
    func nextViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let categorie3 = storyboard.instantiateViewControllerWithIdentifier("hardeskillz2")
        navigationController?.pushViewController(categorie3, animated: true)
        
    }
    
    
    func objectCParse() {
        let text = "Objective C"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["planguage"] = text
                
                object?.saveInBackgroundWithBlock({ (succes, error) -> Void in
                    if(succes) {
                        print("success saving text")
                    } else {
                        (" error saving text")
                    }
                })
                
            }
        }
        
    }
    

    func swiftParse() {
        let text = "Swift"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["planguage"] = text
                
                object?.saveInBackgroundWithBlock({ (succes, error) -> Void in
                    if(succes) {
                        print("success saving text")
                    } else {
                        (" error saving text")
                    }
                })
                
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        if PFUser.currentUser() != nil {
        
        let user = PFUser.currentUser()
        let photo = user?.objectForKey("photoUser")
        self.pfPhoto.file = (photo as? PFFile?)!
        
        pfPhoto.layer.masksToBounds = false
        pfPhoto.layer.cornerRadius = pfPhoto.frame.height/2
        pfPhoto.clipsToBounds = true
        
        pfPhoto.loadInBackground()
        
        
        swiftParse()
        objectCParse()
        }
    }

    

    
    override func viewWillAppear(animated: Bool) {
       
        objCbutton.layer.cornerRadius = 10
        objCbutton.layer.borderWidth = 1
        objCbutton.layer.borderColor = UIColor.blackColor().CGColor
        
        swiftButton.layer.cornerRadius = 10
        swiftButton.layer.borderWidth = 1
        swiftButton.layer.borderColor = UIColor.blackColor().CGColor
       
        
        self.navigationController?.navigationBarHidden = false
        
        let user = PFUser.currentUser()
        let name = user?.valueForKey("username")
        userLabel.text = name as? String

    }
    
}