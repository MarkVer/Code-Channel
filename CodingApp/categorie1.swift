//
//  categorie1.swift
//  CodingApp
//
//  Created by Rosa Meijers on 14-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

class categorie1VC: UIViewController, FBSDKLoginButtonDelegate {
    
    var currentUser = PFUser.currentUser()
    
    @IBOutlet var iOSbutton: UIButton!
    @IBOutlet var androidButton: UIButton!
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {}
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {}
    
    
    @IBOutlet var pfPhoto: PFImageView!
    @IBOutlet var userLabel: UILabel!
    
    
    @IBAction func profielButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyboard.instantiateViewControllerWithIdentifier("TapVC")
        tabbarVC.tabBarController?.selectedIndex = 1
        navigationController?.pushViewController(tabbarVC, animated: true)
        print("check")
        print(tabbarVC.tabBarController?.selectedIndex)
    }
    
    
    @IBAction func iOSbutton(sender: AnyObject) {
        OSIOStoParse()
        self.nextViewController()
        
    }
    
    @IBAction func androidButton(sender: AnyObject) {
        OSandroidtoParse()
        self.nextViewController2()
    }
    
    @IBAction func skipthisbutton(sender: AnyObject) {
        self.nextViewController()
        
    }
    
    
    @IBAction func skipallesButton(sender: AnyObject) {
        self.skipViewController()
    }
    func nextViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let categorie2 = storyboard.instantiateViewControllerWithIdentifier("hardeskillz")
        navigationController?.pushViewController(categorie2, animated: true)
        
    }
    func nextViewController2() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let categorie2 = storyboard.instantiateViewControllerWithIdentifier("hardeskillzAndroid")
        navigationController?.pushViewController(categorie2, animated: true)
        
    }
    
    func skipViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let skipall = storyboard.instantiateViewControllerWithIdentifier("TapVC")
        navigationController?.pushViewController(skipall, animated: true)
        
    }
    
    
    func OSandroidtoParse() {
        let text1 = "Android"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["platformlanguage"] = text1
                
                
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
    
    
    
    
    func OSIOStoParse() {
        let text1 = "iOS"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["platformlanguage"] = text1
                
                
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
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.title = "Android/iOS"
        
        
        iOSbutton.layer.cornerRadius = 10
        iOSbutton.layer.borderWidth = 1
        iOSbutton.layer.borderColor = UIColor.blackColor().CGColor
        
        androidButton.layer.cornerRadius = 10
        androidButton.layer.borderWidth = 1
        androidButton.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    
    
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        
        if PFUser.currentUser() != nil {
        let user = PFUser.currentUser()
        let photo = user?.objectForKey("photoUser")
        self.pfPhoto.file = (photo as? PFFile?)!
        
        pfPhoto.layer.masksToBounds = false
        pfPhoto.layer.cornerRadius = pfPhoto.frame.height/2
        pfPhoto.clipsToBounds = true
        
        pfPhoto.loadInBackground()
            
        }
        
  
        
        let name = currentUser?.valueForKey("username")
        userLabel.text = name as? String
        
        self.navigationController?.navigationBarHidden = false
        
        
    }
    
 
}


