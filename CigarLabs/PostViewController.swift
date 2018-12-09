
import UIKit
import Parse
import ParseLiveQuery
import Photos

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionField: UITextField!
    // initialize the following variables
    var captionPost = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func onShare(_ sender: Any) {
        //  MBProgressHUD.showAdded(to: self.view, animated: true)
        print("onShare was called")
        captionPost = captionField.text ?? ""
        Post.postUserImage(withCaption: captionPost) { (status: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Post successful")
                //       MBProgressHUD.hide(for: self.view, animated: true)
                //Goes back to feed after posting
                self.tabBarController?.selectedIndex = 0
                //Reset photo selected
//                self.imagePost = UIImage(named: "imageName")
                self.captionPost = ""
            }
        }
        // segue to home vc

        self.performSegue(withIdentifier: "AuthenticatedViewController", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
