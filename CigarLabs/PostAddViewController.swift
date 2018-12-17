
import UIKit
import Parse
import ParseLiveQuery
import Photos
import Pages

class DeviceAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    // initialize the following variables
    var captionDevice = ""
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
        captionDevice = captionField.text ?? ""
        Device.postUserImage(withCaption: captionDevice) { (status: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Device successful")
                //       MBProgressHUD.hide(for: self.view, animated: true)
                self.captionDevice = ""

                let sb = UIStoryboard(name: "Main", bundle: nil)
                if let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController {
                    self.present(vc, animated: true, completion: nil)
                }
            }
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
