
import Foundation

import QuickTableViewController
import Parse

class HumidifierSettingsViewController: QuickTableViewController {

    var device: PFObject?
    @IBOutlet weak var seasoningModeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        initSettings()
    }

    private func initSettings() {
        let tempSection = RadioSection(title: "Temperature reading:", options: [
            OptionRow(title: "Celcius", isSelected: true, action: { [weak self] in self?.didToggleTempOption(device: self!.device!,$0) }),
            OptionRow(title: "Fahrenheit", isSelected: false, action: { [weak self] in self?.didToggleTempOption(device: self!.device!,$0) }),
            ])
        tempSection.alwaysSelectsOneOption = true

        let powerSection = RadioSection(title: "Adjust Power Level:", options: [
            OptionRow(title: "Low", isSelected: false, action: didTogglePowerOption()),
            OptionRow(title: "Medium", isSelected: true, action: didTogglePowerOption()),
            OptionRow(title: "High", isSelected: false, action: didTogglePowerOption())
            ], footer: "See app settings for more details on power levels.")
        powerSection.alwaysSelectsOneOption = true

        var boAlert = false
        if(self.device!["boxOpenAlertSetting"] != nil && self.device!.object(forKey: "boxOpenAlertSetting") as! Bool) {
            boAlert = true
        }

        var wlAlert = false
        if(self.device!["waterLevelAlertSetting"] != nil && self.device!.object(forKey: "waterLevelAlertSetting") as! Bool) {
            wlAlert = true
        }

        var seasoningAlert = false
        if(self.device!["seasoningModeSetting"] != nil && self.device!.object(forKey: "seasoningModeSetting") as! Bool) {
            seasoningAlert = true
        }

        var sentryAlert = false
        if(self.device!["sentryModeSetting"] != nil && self.device!.object(forKey: "sentryModeSetting") as! Bool) {
            sentryAlert = true
        }

        let switchesSection = Section(title: "", rows: [
            SwitchRow(title: "Box Open Alerts", switchValue: boAlert, action: didToggleSwitch()),
            SwitchRow(title: "Water Level Alerts", switchValue: wlAlert, action: didToggleSwitch()),
            SwitchRow(title: "Seasoning Mode", switchValue: seasoningAlert, action: didToggleSwitch()),
            SwitchRow(title: "Sentry Mode", switchValue: sentryAlert, action: didToggleSwitch()),
            ])

        tableContents = [
            tempSection,

            powerSection,

            switchesSection,

            Section(title: "Remove Humidifier", rows: [
                TapActionRow(title: "Remove Humidifier", action: { [weak self] in self?.showAlertForRemoveHumidifier($0) })
                ]),

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

    private func didToggleTempOption(device: PFObject, _ sender: Row) {
        print("tf called", sender.title)
        if sender.title == "Celcius" {
            device["temperatureReading"] = "C"
            device.saveInBackground()
            print("setting to C")
        }
        if sender.title == "Fahrenheit" {
            device["temperatureReading"] = "F"
            device.saveInBackground()
            print("setting to F")
        }
    }

    private func didTogglePowerOption() -> (Row) -> Void {
        return { [weak self] in
            if let option = $0 as? OptionRowCompatible, option.isSelected {
                if option.title == "Low" {
                    self!.device!["powerSetting"] = "Low"
                    self!.device!.saveInBackground()
                    print("setting to Low")
                }
                if option.title == "Medium" {
                    self!.device!["powerSetting"] = "Medium"
                    self!.device!.saveInBackground()
                    print("setting to Medium")
                }
                if option.title == "High" {
                    self!.device!["powerSetting"] = "High"
                    self!.device!.saveInBackground()
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
                    self!.device!["boxOpenAlertSetting"] = row.switchValue
                    self!.device!.saveInBackground()
                    print("boxOpen saved as ", row.switchValue)
                }
                if row.title == "Water Level Alerts" {
                    self!.device!["waterLevelAlertSetting"] = row.switchValue
                    self!.device!.saveInBackground()
                    print("waterLevel saved as ", row.switchValue)
                }
                if row.title == "Seasoning Mode" {
                    self!.device!["seasoningModeSetting"] = row.switchValue
                    self!.device!.saveInBackground()
                    print("seasoningMode saved as ", row.switchValue)
                    if row.switchValue == true {
                        self!.device!["sentryModeSetting"] = false
                        self!.device!.saveInBackground()
                        self!.initSettings()

                        self!.performSegue(withIdentifier: "seasoningMode", sender: nil)
                    }
                }
                if row.title == "Sentry Mode" {
                    self!.device!["sentryModeSetting"] = row.switchValue
                    self!.device!.saveInBackground()
                    print("sentryMode saved as ", row.switchValue)

                    if row.switchValue == true {
                        self!.device!["seasoningModeSetting"] = false
                        self!.device!.saveInBackground()
                        self!.initSettings()

                        self!.performSegue(withIdentifier: "sentryMode", sender: nil)
                    }
                }
            }
        }
    }

    private func showAlertForRemoveHumidifier(_ sender: Row) {
        let alertController = UIAlertController(title: "Are you sure you want to remove the humidifer? This action is irreversable.", message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Remove", style: .destructive, handler: { action in
            print("ok clicked")
            self.device!.deleteEventually()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController {
                self.present(vc, animated: true, completion: nil)
            }
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let device = self.device
        if segue.identifier == "seasoningMode" {
            let seasoningModeViewController = segue.destination as! SeasoningModeViewController
            seasoningModeViewController.device = device
        }
        if segue.identifier == "sentryMode" {
            let sentryModeViewController = segue.destination as! SentryModeViewController
            sentryModeViewController.device = device
        }
    }

}
