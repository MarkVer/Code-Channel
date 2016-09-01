import UIKit

class categorie4VC: UIViewController {
    
    @IBOutlet var javaButton: UIButton!
    @IBOutlet var cButton: UIButton!
    
    @IBAction func profielButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profiel = storyboard.instantiateViewControllerWithIdentifier("profielVC")
        navigationController?.pushViewController(profiel, animated: true)
    }
    
    @IBOutlet var pfPhoto: PFImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBAction func javaButton(sender: AnyObject) {
        javaParse()

        self.nextViewController()
    }
    @IBAction func cplusButton(sender: AnyObject) {
        cPlusParse()
        self.nextViewController()
    }
    
    @IBAction func skipThisAndroid(sender: AnyObject) {
        self.nextViewController()
    }
    
    func nextViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let categorie4 = storyboard.instantiateViewControllerWithIdentifier("hardeskillz2")
        navigationController?.pushViewController(categorie4, animated: true)
        
    }
    
    
    func javaParse () {
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
    
    
    func cPlusParse() {
        let text = "C"
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
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false

        javaButton.layer.cornerRadius = 10
        javaButton.layer.borderWidth = 1
        javaButton.layer.borderColor = UIColor.blackColor().CGColor
        
        cButton.layer.cornerRadius = 10
        cButton.layer.borderWidth = 1
        cButton.layer.borderColor = UIColor.blackColor().CGColor
        

        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let user = PFUser.currentUser()
        let photo = user?.objectForKey("photoUser")
        self.pfPhoto.file = (photo as? PFFile?)!
        
        pfPhoto.layer.masksToBounds = false
        pfPhoto.layer.cornerRadius = pfPhoto.frame.height/2
        pfPhoto.clipsToBounds = true
        
        pfPhoto.loadInBackground()
        
    }
    
    
    
}