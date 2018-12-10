
import UIKit
import Parse
import ParseLiveQuery
import Photos
import Pages

class PostAddContainerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionField: UITextField!
    // initialize the following variables
    var captionPost = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
//        self.performSegue(withIdentifier: "PostAddViewController", sender: nil)
        var sb = UIStoryboard(name: "Main", bundle: nil)
        print("sb:", sb)
        if let vc = sb.instantiateViewController(withIdentifier: "PostAddViewController") as? PostAddViewController {
//            vc.newsObj = newsObj
            present(vc, animated: true, completion: nil)
        }
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
