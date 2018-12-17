
import Foundation

import QuickTableViewController
import Parse

class ProfileViewController: QuickTableViewController, UITextFieldDelegate {

    @IBOutlet weak var seasoningModeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let user = PFUser.current()
        var fullName: String?
        if user!["fullName"] == nil {
            user!["fullName"] = ""
            fullName = ""
        } else {
            fullName = "\(user!["fullName"] as! String)"
        }

        var email: String?
        if user!["email"] == nil {
            user!["email"] = ""
            email = ""
        } else {
            email = "\(user!["email"] as! String)"
        }

        var seAlert = false
        if(user!["sendEmailAlertsSetting"] != nil && user!.object(forKey: "sendEmailAlertsSetting") as! Bool) {
            seAlert = true
        }

        var epnAlert = false
        if(user!["enablePushNotificationsSetting"] != nil && user!.object(forKey: "enablePushNotificationsSetting") as! Bool) {
            epnAlert = true
        }

        tableContents = [
            Section(title: "Info", rows: [
                NavigationRow(title: "Full Name", subtitle: .rightAligned(fullName ?? ""), icon: .named("time"), action: showFullnameDetail()),
                NavigationRow(title: "Email", subtitle: .rightAligned(email ?? ""), icon: .named("time"), action: showEmailDetail()),
                ]),

            Section(title: "Settings", rows: [
                SwitchRow(title: "Send Email Alerts", switchValue: seAlert, action: didToggleSwitch()),
                SwitchRow(title: "Enable Push Notifications", switchValue: epnAlert, action: didToggleSwitch()),
                ]),

            Section(title: "Change Password", rows: [
                TapActionRow(title: "Change Password", action: showPasswordDetail())
                ]),
        ]
    }

    // MARK: - Actions

    private func showAlert(_ sender: Row) {
        // ...
    }

    private func didToggleSwitch() -> (Row) -> Void {
        return { [weak self] in
            if let row = $0 as? SwitchRowCompatible {
                let state = "\(row.title) = \(row.switchValue)"
                let user = PFUser.current()
                print(state)
                if row.title == "Send Email Alerts" {
                    user!["sendEmailAlertsSetting"] = row.switchValue
                    user!.saveInBackground()
                    print("sendEmailAlertsSetting saved as ", row.switchValue)
                }
                if row.title == "Enable Push Notifications" {
                    user!["enablePushNotificationsSetting"] = row.switchValue
                    user!.saveInBackground()
                    print("enablePushNotificationsSetting saved as ", row.switchValue)
                }
            }
        }
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

    private func showPasswordDetail() -> (Row) -> Void {
        return { [weak self] in
            let detail = $0.title
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            controller.title = detail

            let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
            //            sampleTextField.placeholder = ""
            sampleTextField.text = ""
            sampleTextField.tag = 2
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

        if textField.tag == 0 {
            let user = PFUser.current()
            user?["fullName"] = textField.text
            user?.saveInBackground()
        }
        if textField.tag == 1 {
            let user = PFUser.current()
            user?["email"] = textField.text
            user?.saveInBackground()
        }
        if textField.tag == 2 {
            if textField.text != "" {
                let currentUser = PFUser.current()
                currentUser!.password = textField.text

                currentUser!.saveInBackground() { (success, error) in
                    if success {
                        PFUser.logInWithUsername(inBackground: currentUser!.email!, password: currentUser!.password!) { (user, error) in
                            let alert = UIAlertController(title: "Alert", message: "Password Updated.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }

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
