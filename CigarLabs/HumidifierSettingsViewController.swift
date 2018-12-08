
import Foundation

import QuickTableViewController

class HumidifierSettingsViewController: QuickTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableContents = [
            RadioSection(title: "Temperature reading:", options: [
                OptionRow(title: "Celcius", isSelected: true, action: didToggleOption()),
                OptionRow(title: "Fahrenheit", isSelected: false, action: didToggleOption()),
                ]),

            RadioSection(title: "Adjust Power Level:", options: [
                OptionRow(title: "Low", isSelected: false, action: didToggleOption()),
                OptionRow(title: "Medium", isSelected: true, action: didToggleOption()),
                OptionRow(title: "High", isSelected: false, action: didToggleOption())
                ], footer: "See app settings for more details on power levels."),

            Section(title: "", rows: [
                SwitchRow(title: "Box Open Alerts", switchValue: true, action: { _ in }),
                SwitchRow(title: "Water Level Alerts", switchValue: false, action: { _ in }),
                SwitchRow(title: "Seasoning Mode", switchValue: false, action: { _ in }),
                SwitchRow(title: "Sentry Mode", switchValue: false, action: { _ in }),
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

    private func showAlert(_ sender: Row) {
        // ...
    }

    private func didToggleOption() -> (Row) -> Void {
        return { [weak self] row in
            // ...
        }
    }

}
