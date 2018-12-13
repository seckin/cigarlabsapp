
import Foundation

import QuickTableViewController
import Parse

class ProfileViewController: QuickTableViewController, UITextFieldDelegate {

    var post: PFObject?
    @IBOutlet weak var seasoningModeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableContents = [
            Section(title: "Info", rows: [
                NavigationRow(title: "Full Name", subtitle: .rightAligned("Seckin Can Sahin"), icon: .named("time"), action: showDetail()),
                NavigationRow(title: "Email", subtitle: .rightAligned("seckincansahin@gmail.com"), icon: .named("time"), action: { _ in }),
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

    private func didToggleTempOption(post: PFObject, _ sender: Row) {
        print("tf called", sender.title)
        if sender.title == "Celcius" {
            post["temperatureReading"] = "C"
            post.saveInBackground()
            print("setting to C")
        }
        if sender.title == "Fahrenheit" {
            post["temperatureReading"] = "F"
            post.saveInBackground()
            print("setting to F")
        }
    }

    private func didTogglePowerOption() -> (Row) -> Void {
        return { [weak self] in
            if let option = $0 as? OptionRowCompatible, option.isSelected {
                //                print("here1", option.title)
                if option.title == "Low" {
                    self!.post!["powerSetting"] = "Low"
                    self!.post!.saveInBackground()
                    print("setting to Low")
                }
                if option.title == "Medium" {
                    self!.post!["powerSetting"] = "Medium"
                    self!.post!.saveInBackground()
                    print("setting to Medium")
                }
                if option.title == "High" {
                    self!.post!["powerSetting"] = "High"
                    self!.post!.saveInBackground()
                    print("setting to High")
                }
            }
        }
    }

    private func didToggleSwitch() -> (Row) -> Void {
        return { [weak self] in
            if let row = $0 as? SwitchRowCompatible {
                let state = "\(row.title) = \(row.switchValue)"
                print(state)
                if row.title == "Box Open Alerts" {
                    self!.post!["boxOpenAlertSetting"] = row.switchValue
                    self!.post!.saveInBackground()
                    print("boxOpen saved as ", row.switchValue)
                }
                if row.title == "Water Level Alerts" {
                    self!.post!["waterLevelAlertSetting"] = row.switchValue
                    self!.post!.saveInBackground()
                    print("waterLevel saved as ", row.switchValue)
                }
                if row.title == "Seasoning Mode" {
                    self!.post!["seasoningModeSetting"] = row.switchValue
                    self!.post!.saveInBackground()
                    print("seasoningMode saved as ", row.switchValue)

                    //                    self!.seasoningModeButton.sendActions(for: .touchUpInside)
                    self!.performSegue(withIdentifier: "seasoningMode", sender: nil)
                }
                if row.title == "Sentry Mode" {
                    self!.post!["sentryModeSetting"] = row.switchValue
                    self!.post!.saveInBackground()
                    print("sentryMode saved as ", row.switchValue)
                    self!.performSegue(withIdentifier: "sentryMode", sender: nil)
                }
            }
        }
    }

    private func showDetail() -> (Row) -> Void {
        return { [weak self] in
            let detail = $0.title + ($0.subtitle?.text ?? "")
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            controller.title = detail

            let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
            sampleTextField.placeholder = "Enter text here"
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
//            self?.showDebuggingText(detail + " is selected")
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }
}
