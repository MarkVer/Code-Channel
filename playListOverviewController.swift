//
//  videoTableViewController.swift
//  CodingApp
//
//  Created by Mark Verwoerd en de rest on 03/03/16.

import UIKit


class playListOverviewController: UITableViewController {
    
    
    var videoArray = []
    var playListName: String = ""
    var videoObject = GTLYouTubeVideo()
    
    
    var arrayPlayList = ["Parse Tutorials","Firebase Tutorials","How To Make a YouTube Video App","How to make a shopping app","Java Tutorials beginners"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationController?.navigationBar.hidden = false
 
        
        TAAYouTubeWrapper.videosForPlaylist(playListName, forChannel: "UCgQGP7lTgAgZsn8YZayX_uQ") {
            
            (succeeded, videos, error)-> Void in

            if videos != nil {
                self.videoArray = videos
                self.tableView.reloadData()
             
               
                
            }
            
        }
        
        self.navigationController?.navigationBarHidden = false
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        print(videoArray.count)
        return videoArray.count
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("playListCell") as! playListCell
        
        videoObject = videoArray[indexPath.row] as! GTLYouTubeVideo
        let videoTitle = videoObject.snippet.title
        
        print(videoObject.identifier)
        
        let imageUrl = videoObject.snippet.thumbnails.standard.url
        let url = NSURL(string: imageUrl)
        let data = NSData(contentsOfURL: url!)
        let image = UIImage(data: data!)
        
        cell.ImageViewPlaylist.image = image
        cell.playListNameLabel.text = videoTitle
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Segue2"  {
            
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let videoDetail = segue.destinationViewController as! videoDetailViewController
                videoDetail.videoObject = videoArray[row] as! GTLYouTubeVideo
                
            }
            
            
        }
        
    }
    
    
    
}