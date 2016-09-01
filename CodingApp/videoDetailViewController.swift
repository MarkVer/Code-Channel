//
//  videoDetailViewController.swift
//  CodingApp
//
//  Created by Mark Verwoerd on 09/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

// MARK: - Class

class videoDetailViewController: UIViewController, YTPlayerViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    // MARK: - Outlets
    
    @IBOutlet var commentTableView: UITableView!
    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet var videoTittle: UILabel!
    @IBOutlet var hartjeRood: UIButton!
    @IBOutlet var commentText: UIView!
    @IBOutlet var commentTextFieldInput: UITextField!
    
    var videoArray = []
    var commentsArray = [PFObject]()
    var refreshControl: UIRefreshControl!
    
    func displayMyAlertMessage(userMessage: String) {
        
        let myAlert = UIAlertController(title: "Yes!", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(alertAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    
    func displayMyAlertMessage2(userMessage: String) {
        
        let myAlert = UIAlertController(title: "Woopsie!", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(alertAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    


    
    
    @IBAction func commentSave(sender: AnyObject) {
        
        if PFUser.currentUser() != nil && commentTextFieldInput.text != "" {
            
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
            query.getFirstObjectInBackgroundWithBlock({ (object, error) in
              
                if object == nil || error != nil {
                    print("the user object request has failed")
                    print(object)
                } else {
                    
                    print("user object request succeeded")
                    print(object)
                    
                    let newComment = Comment(comment: (self.commentTextFieldInput.text)!, user: PFUser.currentUser()!)
                    let id = self.videoObject.identifier as String
                    let videoName = self.videoObject.snippet.title as String
                    let username = PFUser.currentUser()?.username
                    
                    newComment["videoID"] = id
                    newComment["userID"] = username
                    newComment["userPhoto"] = object!["photoUser"]
                    
                    newComment.saveInBackgroundWithBlock({ (succes, error) in
                        if (succes) {
                            self.displayMyAlertMessage("Comment saved")
                            self.commentsParse()
                            self.commentTableView.reloadData()

                        }
                    })
                }
            })
                }
     
        }
        
    
    
    @IBAction func likeButton(sender: AnyObject) {
        if PFUser.currentUser() != nil {
        //        let videoID = [videoObject.identifier]
        let id = videoObject.identifier
        //        print(videoID)
        let User = PFUser()
        self.hartjeRood.hidden = false
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            //checken of er een object bestaat voor die username
            if object == nil && error != nil {
                print("the video object request has failed")
                
                print(object)
            } else {
                // object gevonden voor username
                print("video object request succeeded")
                
                // checken of er een value voor de videoArray is
                //value is niet nil
                if object!["videoArray"] != nil {
                    print("hij is niet nil")
                    print(object?.valueForKey("videoArray"))
                    
                    
                    let videoArray = object?["videoArray"] as! [String]
                    print(videoArray)
                    print(id)
                    
                    if videoArray.contains(id) {
                        print("hij zit in de array")
                        print("hart moet rood zijn")
                        
                    } else {
                        print("id is niet hetzelfde als 1 andere id")
                        
                        object?.addObject(id, forKey: "videoArray")
                        object?.saveInBackgroundWithBlock({ (succes, error) -> Void in
                            if(succes) {
                                print("success appending ID")
                                print("hartje moet rood worden")
                            } else {
                                ("error saving videoID")
                            }
                        })
                        
                        print("hij zit er niet in")
                    }
                    
                    
                } else {
                    //er is geen value in de Array
                    
                    print("hij is nil")
                    
                    object!["videoArray"] = [id]
                    object?.saveInBackgroundWithBlock({ (succes, error) -> Void in
                        if(succes) {
                            print("success saving videoID for first time")
                        } else {
                            (" error saving videoID")
                        }
                    })
                }
            }
        }
    }
    }
    var videoName = ""
    
    var videoObject = GTLYouTubeVideo()
    
    
    let playerVars = [
        "playsinline" : 1
    ]
    
    func hartjeParse() {
        
        if PFUser.currentUser() != nil {
            
            let id = videoObject.identifier
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
            query.getFirstObjectInBackgroundWithBlock {
                (object: PFObject?, error: NSError?) -> Void in
                
                //checken of er een object bestaat voor die username
                if object == nil && error != nil {
                    print("the video object request has failed")
                    print(object)
                } else {
                    // object gevonden voor username
                    print("video object request succeeded")
                    
                    // checken of er een value voor de videoArray is
                    //value is niet nil
                    if object!["videoArray"] != nil {
                        print("hij is niet nil")
                        print(object?.valueForKey("videoArray"))
                        let videoArray = object?["videoArray"] as! [String]
                        print(videoArray)
                        print(id)
                        
                        if videoArray.contains(id) {
                            print("hij zit in de array")
                            print("hart moet rood zijn")
                            self.hartjeRood.hidden = false
                            
                            
                        } else {
                            print("id is niet hetzelfde als 1 andere id")
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func deleteLike(sender: AnyObject) {
        deleteFavoParse()
    }
    
    func commentsParse() {
        
        let id = videoObject.identifier
        let query = PFQuery(className: "Comment")
       
        query.orderByDescending("createdAt")
        query.whereKey("videoID", equalTo: (id))
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?)
            -> Void in
            
            if objects == nil || error != nil {
                print("the comment object request has failed")
                print(objects)
            } else {
                print("comment object request succeeded")
                print(objects)
                self.commentsArray = objects!
                print(self.commentsArray)
                self.commentTableView.reloadData()
            }
        }
        
        
        }
    
    
    
    
    func deleteFavoParse() {
        let id = videoObject.identifier
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if self.hartjeRood.hidden == false{
                
                self.hartjeRood.hidden = true
                object?.removeObject(id, forKey: "videoArray")
                object?.saveInBackground()
                print("id removed from array")
            }else{
                
                
            }
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commentsArray.count
       
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell") as! commentCell
        
                let parseComments = commentsArray[indexPath.row] as PFObject
        
         var commentString = parseComments.valueForKey("comment") as! String
        var usernameString = parseComments.valueForKey("userID") as? String
         var userimageFile = parseComments.valueForKey("userPhoto") as? PFFile
        
        let newComment = CommentClass(comment: commentString, user: usernameString!, userImage: userimageFile!)
        
        cell.comment = newComment
        
        
        cell.userImage.layer.masksToBounds = false
        cell.userImage.layer.cornerRadius = cell.userImage.frame.height/2
        cell.userImage.clipsToBounds = true
        cell.setNeedsDisplay()
        

        return cell
    }
    
    
    // MARK: - Actions
    
    // MARK: - Functions
    
    func refresh(sender:AnyObject)
    {
        self.commentTableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        hartjeRood.hidden = true
        hartjeParse()
        
        videoName = videoObject.identifier
        playerView.loadWithVideoId(videoName)
        playerView.playVideo()
        videoTittle.text = videoObject.snippet.title
        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.frame.origin.x = 600
        self.refreshControl.frame.origin.y = 500

        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.commentTableView.addSubview(self.refreshControl) // not required when using UITableViewController
        self.refreshControl.endRefreshing()
    }

    
    
    override func viewWillAppear(animated: Bool) {
        commentsParse()
       
        self.navigationController?.navigationBar.hidden = false

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        self.commentTextFieldInput.delegate = self
        commentTableView.reloadData()
       
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    
    
    
    
    
}