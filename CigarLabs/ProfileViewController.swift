
import Foundation

import QuickTableViewController
import Parse

class ProfileViewController: QuickTableViewController, UITextFieldDelegate {

    var post: PFObject?
    @IBOutlet weak var seasoningModeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let user = PFUser.current()
        let fullName = user!["fullName"] as! String
        let email = user!.email as! String

        tableContents = [
            Section(title: "Info", rows: [
                NavigationRow(title: "Full Name", subtitle: .rightAligned(fullName), icon: .named("time"), action: showFullnameDetail()),
                NavigationRow(title: "Email", subtitle: .rightAligned(email), icon: .named("time"), action: showEmailDetail()),
                ]),

            Section(title: "Settings", rows: [
                SwitchRow(title: "Send Email Alerts", switchValue: true, action: { _ in }),
                SwitchRow(title: "Enable Push Notifications", switchValue: true, action: { _ in }),
                ]),

            Section(title: "Change Password", rows: [
                TapActionRow(title: "Change Password", action: { [weak self] in self?.showAlert($0) })
                ]),
        ]
    }

    // MARK: - Actions

    private func showAlert(_ sender: Row) {
        // ...
    }

    private func showFullnameDetail() -> (Row) -> Void {
        return { [weak self] in
            let detail = $0.title
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            controller.title = detail

            let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
//            sampleTextField.placeholder = ""
            var user = PFUser.current()
            sampleTextField.text = user!["fullName"] as! String
            sampleTextField.tag = 0
            sampleTextField.font = UIFont.systemFont(ofSize: 15)
            sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
            sampleTextField.autocorrectionType = UITextAutocorrectionType.no
            sampleTextField.keyboardType = UIKeyboardType.default
            sampleTextField.returnKeyType = UIReturnKeyType.done
            sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
            sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            sampleTextField.delegate = self
            controller.view.addSubview(sampleTextField)

            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }

    private func showEmailDetail() -> (Row) -> Void {
        return { [weak self] in
            let detail = $0.title
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            controller.title = detail

            let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
            //            sampleTextField.placeholder = ""
            var user = PFUser.current()
            sampleTextField.text = user!.email
            sampleTextField.tag = 1
            sampleTextField.font = UIFont.systemFont(ofSize: 15)
            sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
            sampleTextField.autocorrectionType = UITextAutocorrectionType.no
            sampleTextField.keyboardType = UIKeyboardType.default
            sampleTextField.returnKeyType = UIReturnKeyType.done
            sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
            sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            sampleTextField.delegate = self
            controller.view.addSubview(sampleTextField)

            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let post = self.post
        if segue.identifier == "seasoningMode" {
            let seasoningModeViewController = segue.destination as! SeasoningModeViewController
            seasoningModeViewController.post = post
        }
        if segue.identifier == "sentryMode" {
            let sentryModeViewController = segue.destination as! SentryModeViewController
            sentryModeViewController.post = post
        }
    }

//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        // return NO to disallow editing.
//        print("TextField should begin editing method called")
//        return true
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // became first responder
//        print("TextField did begin editing method called")
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//        print("TextField should snd editing method called")
//        return true
//    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

        print("TextField did end editing method called")
        let user = PFUser.current()
        if textField.tag == 0 {
            user?["fullName"] = textField.text
        }
        if textField.tag == 1 {
            user?["email"] = textField.text
        }
        user?.saveInBackground()
        self.viewDidLoad()
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called", textField.text)
        let user = PFUser.current()
        if textField.tag == 0 {
            user?["fullName"] = textField.text
        }
        if textField.tag == 1 {
            user?["email"] = textField.text
        }
        user?.saveInBackground()
        self.viewDidLoad()
    }

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // return NO to not change text
//        print("While entering the characters this method gets called")
//        return true
//    }
//
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        // called when clear button pressed. return NO to ignore (no notifications)
//        print("TextField should clear method called")
//        return true
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        // called when 'return' key pressed. return NO to ignore.
//        print("TextField should return method called")
//        // may be useful: textField.resignFirstResponder()
//        return true
//    }
}
