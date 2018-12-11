
import UIKit
import Parse
import ParseLiveQuery
import Photos
import Pages

class PostAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    // initialize the following variables
    var captionPost = ""
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Add Device", for: .normal)
        button.addTarget(self, action: #selector(onShare), for: .touchUpInside)
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
//                print("self.tabBarController:",self.tabBarController)
//                self.tabBarController?.selectedIndex = 0
                //Reset photo selected
                //                self.imagePost = UIImage(named: "imageName")
                self.captionPost = ""

                var sb = UIStoryboard(name: "Main", bundle: nil)
                print("sb:", sb)
                if let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController {
                    //            vc.newsObj = newsObj
                    self.present(vc, animated: true, completion: nil)
                }

//                let navigationController = LoginViewController()
//                self.window = UIWindow(frame: UIScreen.main.bounds)
//                self.window?.rootViewController = navigationController
//                self.window?.makeKeyAndVisible()
            }
        }
        // segue to home vc

//        self.performSegue(withIdentifier: "AuthenticatedViewController", sender: nil)

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
