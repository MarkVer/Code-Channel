//
//  profileViewController.swift
//  CodingApp
//
//  Created by S.Laurenssen on 07-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

class profileViewController: UIViewController,UITextFieldDelegate,
    UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var pfNameLabel: UILabel!
    @IBOutlet var pfPhoto: PFImageView!
    @IBOutlet var niveauLabel: UILabel!
    @IBOutlet var iosandriodLabel: UILabel!
    @IBOutlet var taalLabel: UILabel!
    
    
    @IBAction func signOut(sender: AnyObject) {
        if PFUser.currentUser() != nil {
        PFUser.logOut()
            print(" hij zou nu toch echt moeten uitloggen")
            
        } else {
            print("hij denkt dat er geen user is")
        }
        if PFUser.currentUser() == nil {

            print("current user is nil")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let proceedLogin = storyboard.instantiateViewControllerWithIdentifier("loginView")
            navigationController?.pushViewController(proceedLogin, animated: true)

            
            
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                

                self.iosandriodLabel.text = object!["platformlanguage"] as? String
                self.niveauLabel.text = object!["level"] as? String
                self.taalLabel.text = object!["planguage"] as? String

                
                let user = PFUser.currentUser()
                let name = user?.valueForKey("username")
                self.pfNameLabel.text = name as? String
    
                
                let photo = user?.objectForKey("photoUser")
                self.pfPhoto.file = (photo as? PFFile?)!
                self.pfPhoto.layer.masksToBounds = false
                self.pfPhoto.layer.cornerRadius = self.pfPhoto.frame.height/2
                self.pfPhoto.clipsToBounds = true
                
                self.pfPhoto.loadInBackground()
                
                
                
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
    }
    
    func displayMyAlertMessage2(userMessage: String) {
        
        let userAlert = UIAlertController(title: "Oh oh!", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        userAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: { action in
            let appleAndroid = self.storyboard!.instantiateViewControllerWithIdentifier("loginView")
            self.navigationController?.pushViewController(appleAndroid, animated: true)
        }))
        
        
        
        userAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
            
            self.tabBarController?.selectedIndex = 0
            
            
        }))
        
        self.presentViewController(userAlert, animated: true, completion: nil)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
       
        if PFUser.currentUser() == nil {
            displayMyAlertMessage2("Please login to see your profile")
        }
        

        if PFUser.currentUser() != nil {
        
        let user = PFUser.currentUser()
        let name = user?.valueForKey("username")
        pfNameLabel.text = name as? String
        
        let iosandriod = user?.valueForKey("platformlanguage")
        iosandriodLabel.text = iosandriod as? String

        
        let niveau = user?.valueForKey("level")
        niveauLabel.text = niveau as? String
        
        let taal = user?.valueForKey("planguage")
        taalLabel.text = taal as? String
        
        let photo = user?.objectForKey("photoUser")
        self.pfPhoto.file = (photo as? PFFile?)!
        
        pfPhoto.layer.masksToBounds = false
        pfPhoto.layer.cornerRadius = pfPhoto.frame.height/2
        pfPhoto.clipsToBounds = true
        
        pfPhoto.loadInBackground()

   }
    }
    
    private func roundingPFImageView(let aView: UIView!, let cornerRadiusParam: CGFloat!) {
        aView.clipsToBounds = true
        aView.layer.cornerRadius = cornerRadiusParam
    }
    
    
    
}

