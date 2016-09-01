import UIKit

class commentCell: UITableViewCell {
    
    var comment: CommentClass!

    @IBOutlet var userImage: PFImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userComment: UITextView!
    
    override func layoutSubviews() {
        self.userComment.text = comment.comment
        self.userNameLabel.text = comment.user
        self.userImage.file = comment.userImage
        self.userImage.loadInBackground()

        
    }
    override func prepareForReuse() {
        
    }
}

