//
//  videoTableViewController.swift
//  CodingApp


import UIKit


class videoTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    var videos: [Video] = [Video]()
    var videoArray = []
    var filteredplaylist = [PlayList]()
    
    var arrayPlayList = ["Parse Tutorials","Firebase Tutorials","How To Make a YouTube Video App","How to make a shopping app","Java Tutorials beginners"]

    var searchPlayList = [PlayList]()
    var imagefilter = [UIImage] ()
    var playListArray = [PlayList]()
    var resultSearchController = UISearchController()
    var platformFilter = String ()
    var planguageFilter = String ()
    var levelFilter = String ()
 
    
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.navigationController?.navigationBar.hidden = true
        
        self.tableView.contentInset = UIEdgeInsetsMake(20,0,0,0)
        
        self.fillPlaylist()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.resultSearchController.searchBar.placeholder = "Search video's"
        
        
        
        if PFUser.currentUser() != nil {
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
            query.getFirstObjectInBackgroundWithBlock {
                (object: PFObject?, error: NSError?) -> Void in
                if (object != nil) {
                    if  let platform = object?.valueForKey("platformlanguage"){
                        if let language = object?.valueForKey("planguage") {
                            if let level = object?.valueForKey("level"){
                                
                                for i in self.playListArray {
                                    if i.OS == platform as! String {
                                        if i.planguage == language as! String {
                                            if i.level == level as! String {
                                                self.filteredplaylist.append(i)
                                                self.tableView.reloadData()
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                                
                                
                            }
                        }}}
                
                
            }
        }
        
        
        
        
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.tableView.reloadData()
    }
    
    
    func fillPlaylist() {
        
        
        let parseimg = UIImage(named: "parseimg.png")
        let firebaseimg = UIImage(named: "firebaseimg.png")
        let shoppingapp = UIImage(named: "shoppingappimg")
        let youtubeappimg = UIImage(named: "youtubeappimg.png")
   
        
        let beginner = "Beginner"
        let intermediate = "Intermediate"
        let expert = "Expert"
        
        let iOS = "iOS"
        let Android =  "Android"
        
        let swift = "Swift"
        let objective_c = "Objective C"
        let java = "Java"
        
        
        let playlist_parse = PlayList (name: "Parse Tutorials", image:parseimg!, levellabel:beginner, OSlabel: iOS, planguageLabel: swift )
        
        let playlist_firebase = PlayList (name: "Firebase Tutorials", image:firebaseimg!, levellabel:beginner, OSlabel: iOS, planguageLabel: swift )
      
        let playlist_shoppingapp = PlayList (name: "How to make a shopping app", image:shoppingapp!, levellabel:expert, OSlabel: iOS, planguageLabel: swift )
       
        let playlist_youtubeapp = PlayList (name: "How To Make a YouTube Video App", image:youtubeappimg!, levellabel: intermediate, OSlabel: iOS, planguageLabel: swift )
   
        
        playListArray = [playlist_parse, playlist_firebase, playlist_youtubeapp, playlist_shoppingapp]
   
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredplaylist.count > 0 {
            return self.filteredplaylist.count
        } else {
            
            
            if (self.resultSearchController.active)
            {
                return self.searchPlayList.count
                
            }
            else
            {
                
                print(playListArray)
                return self.playListArray.count
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("videoCell") as! videoCell
        
        
        
        if filteredplaylist.count > 0 {
            
            let playlist = filteredplaylist [indexPath.row] as! PlayList
            
            cell.playListNameLabel.text = playlist.name
            cell.ImageViewPlaylist.image = playlist.image
            
            return cell
            
        } else {
            
            
            
            if (self.resultSearchController.active)
            {
                
                
                let filterplaylist = self.searchPlayList[indexPath.row]
                
                cell.playListNameLabel?.text = filterplaylist.name
                cell.ImageViewPlaylist.image = filterplaylist.image
                
                
                
                return cell
            }
            else
            {
                
                let playlist = playListArray [indexPath.row] as! PlayList
                
                
                cell.playListNameLabel.text = playlist.name
                cell.ImageViewPlaylist.image = playlist.image
                
                
                
                return cell
            }
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Segue" {
            
            if let indexPath = tableView.indexPathForSelectedRow?.row {
                
                if filteredplaylist.count > 0   {
                    
                    let playlistOverview = segue.destinationViewController as! playListOverviewController
                    
                    let filterplaylist = filteredplaylist[indexPath]
                    
                    playlistOverview.playListName = filterplaylist.name
                    
                    print(filterplaylist)
                    
                    
                }
                    
                else if (self.resultSearchController.active)  {
                    
                    let playlistOverview = segue.destinationViewController as! playListOverviewController
                    
                    let playlist = searchPlayList[indexPath]
                    
                    playlistOverview.playListName = playlist.name
                    
                }
                    
                else {
                    
                    let playlistOverview = segue.destinationViewController as! playListOverviewController
                    playlistOverview.playListName = arrayPlayList[indexPath]
                    
                    
                }
                
            }
            
        }
        
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.searchPlayList.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        let array = (self.arrayPlayList as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        for i in array {
            print("dit is een array",i)
        }
        
        for i in playListArray {
            for j in array {
                if i.name == j as! String {
                    searchPlayList.append(i)
                    
                }
            }
        }
        
        
        self.tableView.reloadData()
    }
    
    
}