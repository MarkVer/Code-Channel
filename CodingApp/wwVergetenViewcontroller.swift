//
//  wwVergetenViewcontroller.swift
//  CodingApp
//
//  Created by Rosa Meijers on 07-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//  I need to commit something

import UIKit

class wwVergetenViewcontroller: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var typinEmail: UITextField!
    @IBAction func sendPassword(sender: AnyObject) {
        
        
        let emailAddress = typinEmail.text
        if emailAddress == ""
        {
        print("mail not filled in")
            let userMessage: String = "please type in your email address"
            displayMessage(userMessage)
           return
        }
        
        
        PFUser.requestPasswordResetForEmailInBackground(emailAddress!, block: { (success: Bool, error: NSError?) -> Void in
            
            if(error != nil)
            {
                print("error requesting password")
                let userMessage: String = error!.localizedDescription
                self.displayMessage(userMessage)
            } else {
                print("success requesting password")
                let userMessage: String = "An email message was sent to \(emailAddress!)"
                self.displayMessage(userMessage)
            }
        })

        
    }
    
    func displayMessage(userMessage: String)
    {
     let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
     let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
     myAlert.addAction(okAction)
     self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBarHidden = false
        self.typinEmail.delegate = self
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}