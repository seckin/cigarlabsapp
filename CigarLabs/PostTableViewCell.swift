
import UIKit
import Parse

@objc protocol PostTableViewCellDelegate {
    func postCell(_ cell: PostTableViewCell, didLike post: PFObject?)
}


class PostTableViewCell: UITableViewCell {
    
    // identifier: PostCell
    @IBOutlet weak var userView: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userLabel2: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var photoView: PFImageView!

    weak var delegate: PostTableViewCellDelegate?
    var post: PFObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Sets circle profile picture viewer
        userView.layer.borderWidth = 1
        userView.layer.masksToBounds = false
        userView.layer.borderColor = UIColor.white.cgColor
        userView.layer.cornerRadius = userView.frame.height/2
        userView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
