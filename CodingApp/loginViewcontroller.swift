//
//  loginViewcontroller.swift
//  CodingApp
//
//  Created by Rosa Meijers on 03-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class loginViewcontroller: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var proceedButton: UIButton!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var wwVergeten: UIButton!
    
    let permissions = []
    
    @IBAction func proceedLogin(sender: AnyObject) {
        proceedWithoutLoginController()
    }
    func nextViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tapVC = storyboard.instantiateViewControllerWithIdentifier("TapVC")
        navigationController?.pushViewController(tapVC, animated: true)
        
        
    }
    
    func proceedWithoutLoginController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let proceedLogin = storyboard.instantiateViewControllerWithIdentifier("TapVC")
        navigationController?.pushViewController(proceedLogin, animated: true)
        
        
    }
    
    func displayMyAlertMessage(userMessage: String) {
        
        let myAlert = UIAlertController(title: "Woopsie", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(alertAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    func loginMessage(userMessage: String) {
        
        let myAlert = UIAlertController(title: "Succes", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        myAlert.addAction(alertAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        
        let user = PFUser()
        user.username = username.text
        user.password = password.text
        
        if username.text != "" && password.text != "" {
            if PFUser.currentUser() == nil {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: {
                    (User: PFUser?, Error: NSError?) -> Void in
                    
                    if User == nil {
                        self.displayMyAlertMessage("Login not succeeded.")
                        print("inloggen mislukt")
                        
                    } else {
                        //Xcode vindt het niet leuk als je twee viewController tegelijk presenteert.
                        //Ook niet als er twee functies op een button zitten (zoals een segue en een voorwaarde)
                        self.nextViewController()
                        self.loginMessage("Welcome \(self.username!.text!)")
                        print("inloggen gelukt")
                        self.nextViewController()
                        
                    }
                })
                
            }
        }
        else if username.text == "" && password.text == "" {
                            print("no data")
                            self.displayMyAlertMessage("please fill in your data")
            
        }
        
    }
    
    @IBAction func signupScreen(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUp = storyboard.instantiateViewControllerWithIdentifier("signUp")
            navigationController?.pushViewController(signUp, animated: true)

        
    }
    
    
    override func viewDidLoad() {
        
        if PFUser.currentUser() != nil {
            PFUser.logOut()
            print(PFUser.currentUser())
            print("no user")
        }
        
        
        
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.blackColor().CGColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.username.delegate = self
        self.password.delegate = self
        
        let user = PFUser()
        user.username = username.text
        user.password = password.text
        
        if username.text != "" && password.text != "" {
            if PFUser.currentUser() == nil {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: {
                    (User: PFUser?, Error: NSError?) -> Void in
                    
                    if User == nil {
                        self.displayMyAlertMessage("Login not succeeded.")
                        print("inloggen mislukt")
                        
                    } else {
                        self.nextViewController()
                        self.loginMessage("Welcome \(self.username!.text!)")
                        print("inloggen gelukt")
                        
                    }
                })
                
            }
        }
        else if username.text == "" && password.text == "" {
                            print("no data")
//                            self.displayMyAlertMessage("please fill in your data")
            
        }
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil {
            PFUser.logOut()
        }
        
        
        self.navigationController?.navigationBarHidden = true
        username.text = ""
        password.text = ""
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}


