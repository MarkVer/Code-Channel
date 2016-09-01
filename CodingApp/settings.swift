//
//  settings.swift
//  CodingApp
//
//  Created by Mark Verwoerd on 15/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//


import UIKit

class settingsViewcontroller: UIViewController{
    
    var currentUser = PFUser.currentUser()
   
    @IBOutlet var iosSwitch: UISwitch!
    @IBOutlet var androidSwitch: UISwitch!
    @IBOutlet var beginnerSwitch: UISwitch!
    @IBOutlet var intermediateSwitch: UISwitch!
    @IBOutlet var expertSwitch: UISwitch!
    @IBOutlet var swiftSwitch: UISwitch!
    @IBOutlet var cSwitch: UISwitch!
    @IBOutlet var javaSwitch: UISwitch!
    @IBOutlet var cAndroid: UISwitch!
   
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func iosAction(sender: AnyObject) {
            if iosSwitch.on {
                self.iOSSwitchtoParse()
            }else{
                self.iOSSwitchDeleteParse()
            }
        }
    
    @IBAction func androidAction(sender: AnyObject) {
        if androidSwitch.on {
           self.AndroidSwitchtoParse()
        }else{
            self.AndroidSwitchDeleteParse()
        }
    }
    
    @IBAction func beginnerAction(sender:AnyObject) {
        if beginnerSwitch.on {
            self.BeginnerSwitchtoParse()
        }else{
            self.BeginnerSwitchDeleteParse()
        }
    }
    
    @IBAction func intermediateAction(sender: AnyObject) {
        if intermediateSwitch.on {
            self.IntermediateSwitchtoParse()
        }else{
            self.IntermediateSwitchDeleteParse()
        }
    }
    
    @IBAction func expertAction(sender: AnyObject) {
        if expertSwitch.on {
            self.ExpertSwitchtoParse()
        }else{
            self.ExpertSwitchDeleteParse()
        }
    }
    
    @IBAction func swiftAction(sender: AnyObject) {
        if swiftSwitch.on {
            self.swiftSwitchtoParse()
        }else{
            self.swiftSwitchDeleteParse()
        }
    }
    
    @IBAction func cAction(sender: AnyObject) {
        if cSwitch.on {
            self.ObjectivecSwitchtoParse()
        }else{
            self.ObjectivecSwitchDeleteParse()
        }
    }
    
    @IBAction func javaAction(sender: AnyObject) {
        if javaSwitch.on {
            self.JavaSwitchtoParse()
        }else{
            self.JavaSwitchDeleteParse()
        }
    }
    
    @IBAction func cAndroid(sender: AnyObject) {
        if cAndroid.on {
            self.cSwitchtoParse()
        }else{
            self.cSwitchDeleteParse()
        }
    }
    
    
    func iOSSwitchtoParse() {
        let text = "iOS"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["platformlanguage"] = text
                
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
    
    func iOSSwitchDeleteParse() {
        let text = "iOS"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                object!["platformlanguage"] = text
               
                
                object?.removeObjectForKey("platformlanguage")
                object?.saveInBackground()
            }
        }
        
    }

   
    func AndroidSwitchtoParse() {
        let text = "Android"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                
                object!["platformlanguage"] = text
                
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
    
    func AndroidSwitchDeleteParse() {
        let text = "Android"
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if object == nil && error != nil {
                print("the object request has failed")
                
                print(object)
            } else {
                print("object request succeeded")
                object!["platformlanguage"] = text
                
                
                object?.removeObjectForKey("platformlanguage")
                object?.saveInBackground()
            }
        }
        
    }
    



    func BeginnerSwitchtoParse() {
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
    
    func BeginnerSwitchDeleteParse() {
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
                
                
                object?.removeObjectForKey("level")
                object?.saveInBackground()
            }
        }
        
    }

    
    func IntermediateSwitchtoParse() {
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
    
    func IntermediateSwitchDeleteParse() {
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
                
                
                object?.removeObjectForKey("level")
                object?.saveInBackground()
            }
        }
        
    }

    
    func ExpertSwitchtoParse() {
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
    
    func ExpertSwitchDeleteParse() {
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
                
                
                object?.removeObjectForKey("level")
                object?.saveInBackground()
            }
        }
        
    }

    
    func swiftSwitchtoParse() {
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
    
    func swiftSwitchDeleteParse() {
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
                
                
                object?.removeObjectForKey("planguage")
                object?.saveInBackground()
            }
        }
        
    }

    
    func ObjectivecSwitchtoParse() {
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
    
    func ObjectivecSwitchDeleteParse() {
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
                
                
                object?.removeObjectForKey("planguage")
                object?.saveInBackground()
            }
        }
        
    }

    
    func JavaSwitchtoParse() {
        let text = "Java"
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
    
    func JavaSwitchDeleteParse() {
        let text = "java"
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
                
                
                object?.removeObjectForKey("planguage")
                object?.saveInBackground()
            }
        }
    }
    
    
    func cSwitchtoParse() {
        let text = "c"
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
    
    func cSwitchDeleteParse() {
        let text = "c"
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
                
                
                object?.removeObjectForKey("planguage")
                object?.saveInBackground()
            }
        }
    }
    
    
        func switchesiOSParse() -> Bool {
            var infoParse: Bool = false
            
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
            query.whereKey("platformlanguage", equalTo: "iOS")
            query.findObjectsInBackgroundWithBlock {
                
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                 self.iosSwitch.setOn(true, animated: true)
                    
                    
                    
                } else {
                infoParse = false
                print("staat niet in Parse")
            }
            
        }
   
    }
            return infoParse
        }
    
    
    func switchesAndroidParse() -> Bool {
        var infoParse: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("platformlanguage", equalTo: "Android")
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                    self.androidSwitch.setOn(true, animated: true)
                    
                    
                    
                } else {
                    infoParse = false
                    print("staat niet in Parse")
                }
                
            }
            
        }
        return infoParse
    }
    
    func switchesBeginnerParse() -> Bool {
        var infoParse: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("level", equalTo: "Beginner")
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                    self.beginnerSwitch.setOn(true, animated: true)
                    
                    
                    
                } else {
                    infoParse = false
                    print("staat niet in Parse")
                }
                
            }
            
        }
        return infoParse
    }
    
    
    func switchesIntermediateParse() -> Bool {
        var infoParse: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("level", equalTo: "Intermediate")
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                    self.intermediateSwitch.setOn(true, animated: true)
                    
                    
                    
                } else {
                    infoParse = false
                    print("staat niet in Parse")
                }
                
            }
            
        }
        return infoParse
    }
    
    func switchesExpertParse() -> Bool {
        var infoParse: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("level", equalTo: "Expert")
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                    self.expertSwitch.setOn(true, animated: true)
                    
                    
                    
                } else {
                    infoParse = false
                    print("staat niet in Parse")
                }
                
            }
            
        }
        return infoParse
    }
    
    func switchesSwiftParse() -> Bool {
        var infoParse: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("planguage", equalTo: "Swift")
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                    self.swiftSwitch.setOn(true, animated: true)
                    
                    
                    
                } else {
                    infoParse = false
                    print("staat niet in Parse")
                }
                
            }
            
        }
        return infoParse
    }

    func switchesObjCParse() -> Bool {
        var infoParse: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("planguage", equalTo: "Objective C")
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                    self.cSwitch.setOn(true, animated: true)
                    
                    
                    
                } else {
                    infoParse = false
                    print("staat niet in Parse")
                }
                
            }
            
        }
        return infoParse
    }

    func switchesJavaParse() -> Bool {
        var infoParse: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("planguage", equalTo: "Java")
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                    self.javaSwitch.setOn(true, animated: true)
                    
                    
                    
                } else {
                    infoParse = false
                    print("staat niet in Parse")
                }
                
            }
            
        }
        return infoParse
    }
    
    func switchesCParse() -> Bool {
        var infoParse: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("planguage", equalTo: "C")
        query.findObjectsInBackgroundWithBlock {
            
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if(objects!.count > 0) {
                    infoParse = true
                    print("staat in Parse")
                    self.cAndroid.setOn(true, animated: true)
                    
                    
                    
                } else {
                    infoParse = false
                    print("staat niet in Parse")
                    self.cAndroid.setOn(false, animated: true)
                }
                
            } else {
                print("error finding objects in Parse")
            }
            
        }
        return infoParse
    }


    
    override func viewDidAppear(animated: Bool) {
        switchesiOSParse()
        switchesAndroidParse()
        switchesBeginnerParse()
        switchesIntermediateParse()
        switchesExpertParse()
        switchesSwiftParse()
        switchesObjCParse()
        switchesJavaParse()
        switchesCParse()
    }
    

    }
