//
//  signupViewcontroller.swift
//  CodingApp
//
//  Created by Rosa Meijers on 03-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class signupViewcontroller: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate {
    
    @IBOutlet var imageView: PFImageView?
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var passwordTwo: UITextField!
    @IBOutlet var emailaddress: UITextField!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var proceedButton: UIButton!
    
    @IBAction func choosePhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func usernameTaken(username: String) -> Bool {
        let userName2 = usernameTF.text
        let enteredUsername = userName2
        var isTaken: Bool = false
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: enteredUsername!)
     
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if (objects!.count > 0){
                    isTaken = true
                    print("username is taken")
                    self.displayMyAlertMessage("Username is already taken")
                } else {
                    print("Username is available. ")
                    self.SignUp()
                }
            } else {
                print("error checking if username is taken")
            }
        }
        
        print(isTaken)
        return isTaken
        
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // Put that image onto the screen in our image view
        imageView?.image = image
        
        
        
        // Take image picker off the screen -
        // you must call this dismiss method
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    // store data - PARSE!!
    
    func SignUp() {
        
        let userPassword = password.text
        let userName = usernameTF.text
        let emailUser = emailaddress.text
        let user = PFUser()
        user.username = userName
        user.password = userPassword
        user.email = emailUser
        
        if imageView!.image != nil{
            let imageData = UIImageJPEGRepresentation(self.imageView!.image!, 1)
            print("image detected")
            let profileImage = PFFile(data: imageData!)
            user.setObject(profileImage!, forKey: "photoUser")

            
        }
        if (imageView?.image == nil) {
            print("no image")
        }
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil {
                self.displayLoginMessage("Sign up succeeded!")
                print("user is signed up")
                
                
            } else {
                ("error signing up")
                self.displayMyAlertMessage("Sign up not succeeded. Please try again")
            }
            
        }
    }
    
    func displayLoginMessage(userMessage: String) {
        
        let userAlert = UIAlertController(title: "Yeah!", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        userAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ action in
            
            print("hoi")
            
            let categorie1 = self.storyboard!.instantiateViewControllerWithIdentifier("appleAndroid")
            self.navigationController?.pushViewController(categorie1, animated: true)
            }))
          
        self.presentViewController(userAlert, animated: true, completion: nil)
        
    }
    
    
    
    func displayMyAlertMessage(userMessage: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        
        myAlert.addAction(alertAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signupTapped(sender: AnyObject) {
        
        let userEmail = emailaddress.text
        let userPassword = password.text
        let userPassword2 = passwordTwo.text
        let userName = usernameTF.text
        
        
        if(userEmail == "" || userPassword == "" || userPassword2 == "" || userName == "") {
            
            displayMyAlertMessage("All field are required")
            
            return
        }
            
        else if(userPassword != userPassword2){
            displayMyAlertMessage("Passwords do not match")
        }
            
        else if(userPassword == userPassword2) {
            
            usernameTaken(userName!)
        }
    }
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.usernameTF.delegate = self
        self.password.delegate = self
        self.passwordTwo.delegate = self
        self.emailaddress.delegate = self
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    


}





