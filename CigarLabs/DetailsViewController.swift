
import UIKit
import Parse

class DetailsViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!

    var post: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let post = post {
            let caption = post["caption"] as? String
            let author = post["author"] as? PFUser

            // Sets circle profile picture viewer
//            userView.layer.borderWidth = 1
//            userView.layer.masksToBounds = false
//            userView.layer.borderColor = UIColor.white.cgColor
//            userView.layer.cornerRadius = userView.frame.height/2
//            userView.clipsToBounds = true

            captionLabel.text = caption
            userLabel.text = author?.username
        }
    }

    @IBAction func CigarLabsBackButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "DetailView", sender: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
