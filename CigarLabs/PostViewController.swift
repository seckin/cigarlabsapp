
import UIKit
import Parse
import ParseLiveQuery
import Photos
import Pages

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionField: UITextField!
    // initialize the following variables
    var captionPost = ""
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        let pages = pagesControllerInCode()

        let navigationController = UINavigationController(rootViewController: pages)

        pages.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous Page",
                                                                 style: .plain,
                                                                 target: pages,
                                                                 action: #selector(PagesController.moveBack))

        pages.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Page",
                                                                  style: .plain,
                                                                  target: pages,
                                                                  action: #selector(PagesController.moveForward))

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func pagesControllerInCode() -> PagesController {
        var viewControllers: [UIViewController] = []

        for i in 0..<5 {
            if let imageURL = URL(string: "https://unsplash.it/375/667/?image=\(i+10)") {
                let viewController = ViewController()
//                viewController.imageView.image(url: imageURL)

//                let url = URL(string: "http://i.imgur.com/w5rkSIj.jpg")
                let data = try? Data(contentsOf: imageURL)

                if let imageData = data {
                    let image = UIImage(data: imageData)
                    viewController.imageView.image = image
                    viewControllers.append(viewController)
                }
            }
        }

        let pages = PagesController(viewControllers)

        pages.enableSwipe = true
        pages.showBottomLine = true

        return pages
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
