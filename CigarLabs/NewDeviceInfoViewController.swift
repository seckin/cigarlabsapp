//
//import Foundation
//
//import SwipeMenuViewController
//
//class NewDeviceInfoViewController: SwipeMenuViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        swipeMenuView.dataSource = self
////        swipeMenuView.delegate = self
////
////        let options: SwipeMenuViewOptions = .init()
////
////        swipeMenuView.reloadData(options: options)
//    }
//}
//extension NewDeviceInfoViewController {
//
//    // MARK: - SwipeMenuViewDelegate
//    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
//        // Codes
//    }
//
//    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
//        // Codes
//    }
//
//    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
//        // Codes
//    }
//
//    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
//        // Codes
//    }
//
//
//    // MARK - SwipeMenuViewDataSource
//    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
//        return 3
//        //array.count
//    }
//
//    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
//        return "asd"
//        //array[index]
//    }
//
//    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
//        let vc = ContentViewController()
//        return vc
//    }
//}
