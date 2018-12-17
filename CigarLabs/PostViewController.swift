
import UIKit
import Parse
import ParseLiveQuery
import Photos
import Pages

class DeviceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionField: UITextField!
    // initialize the following variables
    var captionDevice = ""
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        let pages = pagesControllerInCode()

        let navigationController = UINavigationController(rootViewController: pages)

        pages.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous Step",
                                                                 style: .plain,
                                                                 target: pages,
                                                                 action: #selector(PagesController.moveBack))

        pages.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Step",
                                                                  style: .plain,
                                                                  target: pages,
                                                                  action: #selector(PagesController.moveForward))

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func pagesControllerInCode() -> PagesController {
        var viewControllers: [UIViewController] = []

        let viewController1 = ViewController()
        viewController1.imageView.image = UIImage(named:"step_1_power_respire")
        viewControllers.append(viewController1)

        let viewController2 = ViewController()
        viewController2.imageView.image = UIImage(named:"step_2_make_sure_wifi_is_on")
        viewControllers.append(viewController2)

        let viewController3 = ViewController()
        viewController3.imageView.image = UIImage(named:"step_3_go_to_your_phones_wifi_settings")
        viewControllers.append(viewController3)

        let viewController4 = ViewController()
        viewController4.imageView.image = UIImage(named:"step_4_wifi_networks")
        viewControllers.append(viewController4)

        let viewController5 = ViewController()
        viewController5.imageView.image = UIImage(named:"step_5_wifi_password_for_selected_network")
        viewControllers.append(viewController5)

        let viewController6 = DeviceAddContainerViewController()
        viewControllers.append(viewController6)

        let pages = PagesController(viewControllers)

        pages.enableSwipe = false
        pages.showBottomLine = false

        return pages
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
