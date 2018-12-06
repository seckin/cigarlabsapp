
import UIKit
import Parse

@objc protocol PostTableViewCellDelegate {
    func postCell(_ cell: PostTableViewCell, didLike post: PFObject?)
}


class PostTableViewCell: UITableViewCell {
    
    // identifier: PostCell
    @IBOutlet weak var userView: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var photoView: PFImageView!

    weak var delegate: PostTableViewCellDelegate?
    var post: PFObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
