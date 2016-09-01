//
//  categorie1.swift
//  CodingApp
//
//  Created by Rosa Meijers on 14-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

class categorie3VC: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var beginnerButton: UIButton!
    @IBOutlet var interButton: UIButton!
    @IBOutlet var expertButton: UIButton!
    
    
    
    @IBOutlet var pfPhoto: PFImageView!
    @IBAction func profielButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profiel = storyboard.instantiateViewControllerWithIdentifier("profielVC")
        navigationController?.pushViewController(profiel, animated: true)
    }
    
    @IBAction func beginnerButton(sender: AnyObject) {
        beginnerParse()
        self.nextViewController()
    }
    
    @IBAction func intermediateButton(sender: AnyObject) {
        intermediateParse()
        self.nextViewController()
    }
    
    @IBAction func expertButton(sender: AnyObject) {
        expertParse()
        self.nextViewController()
    }
    
    @IBAction func skipThisAll(sender: AnyObject) {
        self.nextViewController()
    }
  
    
    func nextViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let categorie4 = storyboard.instantiateViewControllerWithIdentifier("TapVC")
        navigationController?.pushViewController(categorie4, animated: true)
        
    }
    
    
    func beginnerParse() {
        let text = "Beginner"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["level"] = text
                
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

    

    
    
    func intermediateParse(){
        let text = "Intermediate"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["level"] = text
                
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

    

    func expertParse(){
        let text = "Expert"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["level"] = text
                
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
       
       beginnerButton.layer.cornerRadius = 10
       beginnerButton.layer.borderWidth = 1
       beginnerButton.layer.borderColor = UIColor.blackColor().CGColor
        
        interButton.layer.cornerRadius = 10
        interButton.layer.borderWidth = 1
        interButton.layer.borderColor = UIColor.blackColor().CGColor
        
        expertButton.layer.cornerRadius = 10
        expertButton.layer.borderWidth = 1
        expertButton.layer.borderColor = UIColor.blackColor().CGColor
      
        self.navigationController?.navigationBarHidden = false
        
        
        let user = PFUser.currentUser()
        let photo = user?.objectForKey("photoUser")
        self.pfPhoto.file = (photo as? PFFile?)!
        
        pfPhoto.layer.masksToBounds = false
        pfPhoto.layer.cornerRadius = pfPhoto.frame.height/2
        pfPhoto.clipsToBounds = true
        
        pfPhoto.loadInBackground()
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.currentUser()
        let name = user?.valueForKey("username")
        nameLabel.text = name as? String
        
        

        
        
    }
}