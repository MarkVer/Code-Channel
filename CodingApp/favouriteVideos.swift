//
//  profileViewController.swift
//  CodingApp
//
//  Created by S.Laurenssen on 07-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

class favouriteVideosViewController: UITableViewController {
    
    
    var parseArray = []
    var favoVideos = [GTLYouTubeVideo]()
    var videoObject = GTLYouTubeVideo()
    
    
    func videosPlaylist1() {
        TAAYouTubeWrapper.videosForPlaylist("all video's", forChannel: "UCgQGP7lTgAgZsn8YZayX_uQ"){
            (succeeded, videos, error)-> Void in
            
            if videos != nil {
                
                for i in videos {
                    let videoObject = i as! GTLYouTubeVideo
                    
                    var videoID = videoObject.identifier
                    print(videoID)
                    
                    for id in self.parseArray {
                        
                        if id as! String == videoID {
                            print("same")
                            print(videoObject)
                            
                            self.favoVideos.append(videoObject)
                            
                            
                        } else {
                            print("not the same")
                        }
                        
                        
                    }
                    
                    print(self.favoVideos)
                    self.tableView.reloadData()
                    
                    
                    
                }
                
            }
        }
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(parseArray.count)
        
        return parseArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("videoFavoCell") as? videoFavoCell
        print(favoVideos)
        print("check")
        print(favoVideos.count)
        print(parseArray.count)
        
        if favoVideos.count > 0 {
            videoObject = favoVideos[indexPath.row] as! GTLYouTubeVideo
            
            let videoTitle = videoObject.snippet.title
            
            print(videoObject.identifier)
            
            let imageUrl = videoObject.snippet.thumbnails.standard.url
            let url = NSURL(string: imageUrl)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            cell!.favoVideoImage!.image = image
            cell!.favoVideoNameLabel!.text = videoTitle
            
            
        } else {
            print("there are no favourite videos to show")
        }
        
        
        
        
        return cell!
    }
    
    func getVideoArrayParse() {
        
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            //value is niet nil
            if object!["videoArray"] != nil {
                print("hij is niet nil")
                print(object?.valueForKey("videoArray"))
                
                
                self.parseArray = object?["videoArray"] as! [String]
                
                self.videosPlaylist1()
                print(self.parseArray)
                
                self.tableView.reloadData()
            }
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("wachten totdat ParseArray is geteld")
            print(self.parseArray.count)
            if self.parseArray.count < 1 {
                print("no favourite videos in Parse")
                self.displayMyAlertMessage("No favourites yet!")
                
            }
            
        }
        
    }
    
    func displayMyAlertMessage(userMessage: String) {
        
        let myAlert = UIAlertController(title: "Woopsie", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(alertAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueDetail"  {
            
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let videoDetail = segue.destinationViewController as! videoDetailViewController
                videoDetail.videoObject = favoVideos[row] as! GTLYouTubeVideo
                
            }
            
            
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() == nil {
            displayMyAlertMessage2("Please login to see your favourites")
        }
        
        if PFUser.currentUser() != nil {
            getVideoArrayParse()
        }
        
        self.tableView.contentInset = UIEdgeInsetsMake(60,0,0,0)
        
        
        self.tableView.reloadData()
    }
    
    
    
    
}