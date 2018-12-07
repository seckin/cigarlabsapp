
import UIKit
import Parse

@objc protocol PostTableViewCellDelegate {
    func postCell(_ cell: PostTableViewCell, didLike post: PFObject?)
}


class PostTableViewCell: UITableViewCell {
    
    // identifier: PostCell
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var colorHolder: UIButton!

    var circleColor: CGColor = UIColor.clear.cgColor

    weak var delegate: PostTableViewCellDelegate?
    var post: PFObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        colorHolder.layer.cornerRadius = 40//colorHolder.bounds.size.height / 2
        colorHolder.layer.backgroundColor = circleColor
        colorHolder.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
