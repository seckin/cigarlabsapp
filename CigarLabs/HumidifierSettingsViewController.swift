
import Foundation

import QuickTableViewController
import Parse

class HumidifierSettingsViewController: QuickTableViewController {

    var post: PFObject?
    @IBOutlet weak var seasoningModeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tempSection = RadioSection(title: "Temperature reading:", options: [
            OptionRow(title: "Celcius", isSelected: true, action: { [weak self] in self?.didToggleTempOption(post: self!.post!,$0) }),
            OptionRow(title: "Fahrenheit", isSelected: false, action: { [weak self] in self?.didToggleTempOption(post: self!.post!,$0) }),
            ])
        tempSection.alwaysSelectsOneOption = true

        let powerSection = RadioSection(title: "Adjust Power Level:", options: [
            OptionRow(title: "Low", isSelected: false, action: didTogglePowerOption()),
            OptionRow(title: "Medium", isSelected: true, action: didTogglePowerOption()),
            OptionRow(title: "High", isSelected: false, action: didTogglePowerOption())
            ], footer: "See app settings for more details on power levels.")
        powerSection.alwaysSelectsOneOption = true

        var boAlert = false
        if(self.post!["boxOpenAlertSetting"] != nil && self.post!.object(forKey: "boxOpenAlertSetting") as! Bool) {
            boAlert = true
        }

        var wlAlert = false
        if(self.post!["waterLevelAlertSetting"] != nil && self.post!.object(forKey: "waterLevelAlertSetting") as! Bool) {
            wlAlert = true
        }

        var seasoningAlert = false
        if(self.post!["seasoningModeSetting"] != nil && self.post!.object(forKey: "seasoningModeSetting") as! Bool) {
            seasoningAlert = true
        }

        var sentryAlert = false
        if(self.post!["sentryModeSetting"] != nil && self.post!.object(forKey: "sentryModeSetting") as! Bool) {
            sentryAlert = true
        }

        tableContents = [
            tempSection,

            powerSection,

            Section(title: "", rows: [
                SwitchRow(title: "Box Open Alerts", switchValue: boAlert, action: didToggleSwitch()),
                SwitchRow(title: "Water Level Alerts", switchValue: wlAlert, action: didToggleSwitch()),
                SwitchRow(title: "Seasoning Mode", switchValue: seasoningAlert, action: didToggleSwitch()),
                SwitchRow(title: "Sentry Mode", switchValue: sentryAlert, action: didToggleSwitch()),
                ]),

//            Section(title: "Tap Action", rows: [
//                TapActionRow(title: "Tap action", action: { [weak self] in self?.showAlert($0) })
//                ]),

//            Section(title: "Navigation", rows: [
//                NavigationRow(title: "CellStyle.default", subtitle: .none, icon: .named("gear")),
//                NavigationRow(title: "CellStyle", subtitle: .belowTitle(".subtitle"), icon: .named("globe")),
//                NavigationRow(title: "CellStyle", subtitle: .rightAligned(".value1"), icon: .named("time"), action: { _ in }),
//                NavigationRow(title: "CellStyle", subtitle: .leftAligned(".value2"))
//                ]),

        ]
    }

    // MARK: - Actions

//    private func showAlert(_ sender: Row) {
//        // ...
//    }

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

}
