//
//  ViewController.swift
//  SettingsApp2
//

import UIKit

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
    case badgeCell(model: SettingsBadgeOption)
}

enum Metrics {
    // Common
    static let numberOfLines = 1
    static let cornerRadius: CGFloat = 10
    static let yZero: CGFloat = 0
    static let sizePadding: CGFloat = 12
    // Icon Container
    static let iconContainerX: CGFloat = 15
    static let iconContainerY: CGFloat = 6
    // Label
    static let labelXMargin: CGFloat = 25
    static let labelWidthMargin: CGFloat = 20
    // Sub Label
    static let subLabelXMargin: CGFloat = 30
    static let subLabelWidth: CGFloat = 80
    // Switch
    static let switchXMargin: CGFloat = 20
    // Badge
    static let badgeWidth: CGFloat = 20
    static let badgeHeight: CGFloat = 20
    static let badgeXMargin: CGFloat = 25
    static let badgeYMargin: CGFloat = 32
}

struct Section {
    let options: [SettingsOptionType]
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let subText: String?
    let handler: (() -> Void)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var isOn: Bool
    let handler: (() -> Void)
}

struct SettingsBadgeOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var count: String
    let handler: (() -> Void)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self,
                       forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        table.register(BadgeTableViewCell.self,
                       forCellReuseIdentifier: BadgeTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure() {
        models.append(Section(options: [
            .switchCell(model: SettingsSwitchOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemOrange, isOn: true ) { print("Tapped Airplane mode cell") }),
            .staticCell(model: SettingsOption(title: "Wi-fi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemBlue, subText: "Home_Net") { print("Tapped Wi-fi cell") }),
            .staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "b.square.fill"), iconBackgroundColor: .link, subText: "On") { print("Tapped Bluetooth cell") }),
            .staticCell(model: SettingsOption(title: "Mobile Data", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .systemGreen, subText: "") { print("Tapped Mobile Data cell") }),
            .staticCell(model: SettingsOption(title: "Personal Hotspot", icon: UIImage(systemName: "personalhotspot"), iconBackgroundColor: .systemGreen, subText: "Off") { print("Tapped Personal Hotspot cell") }),
            .switchCell(model: SettingsSwitchOption(title: "VPN", icon: UIImage(systemName: "network"), iconBackgroundColor: .link, isOn: false) { print("Tapped VPN cell") })
        ]))
        
        models.append(Section(options: [
            .staticCell(model: SettingsOption(title: "Notifications", icon: UIImage(systemName: "note"), iconBackgroundColor: .systemRed, subText: "") { print("Tapped Notifications cell") }),
            .staticCell(model: SettingsOption(title: "Sounds & Haptics", icon: UIImage(systemName: "speaker.wave.3.fill"), iconBackgroundColor: .systemPink, subText: "") { print("Tapped Sounds & Haptic cell") }),
            .staticCell(model: SettingsOption(title: "Do Not Disturb", icon: UIImage(systemName: "moon.fill"), iconBackgroundColor: .systemIndigo, subText: "") { print("Tapped Do Not Disturb cell") }),
            .staticCell(model: SettingsOption(title: "Screen Time", icon: UIImage(systemName: "hourglass"), iconBackgroundColor: .systemIndigo, subText: "") { print("Tapped Screen Time cell") }),
        ]))
        
        models.append(Section(options: [
            .badgeCell(model: SettingsBadgeOption(title: "General", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemGray, count: "2") { print("Tapped General cell") }),
            .staticCell(model: SettingsOption(title: "Control Center", icon: UIImage(systemName: "switch.2"), iconBackgroundColor: .systemGray, subText: "") { print("Tapped Control Center cell") }),
            .staticCell(model: SettingsOption(title: "Display & Brightness", icon: UIImage(systemName: "textformat.size"), iconBackgroundColor: .systemBlue, subText: "") { print("Tapped Display & Brightness cell") }),
            .staticCell(model: SettingsOption(title: "Home Screen", icon: UIImage(systemName: "apps.ipad.landscape"), iconBackgroundColor: .systemIndigo, subText: "") { print("Tapped Home Screen cell") }),
            .staticCell(model: SettingsOption(title: "Accessibility", icon: UIImage(contentsOfFile: "Users/sergei/Downloads/accessibility.png"), iconBackgroundColor: .systemBlue, subText: "") { print("Tapped Accessibility cell") }),
            .staticCell(model: SettingsOption(title: "Wallpaper", icon: UIImage(contentsOfFile: "Users/sergei/Downloads/wallpaper.png"), iconBackgroundColor: .systemTeal, subText: "") { print("Tapped Wallpaper cell") }),
            .staticCell(model: SettingsOption(title: "Siri & Search", icon: UIImage(contentsOfFile: "Users/sergei/Downloads/siri.png"), iconBackgroundColor: .clear, subText: "") { print("Tapped Siri & Search cell") }),
        ]))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .badgeCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BadgeTableViewCell.identifier,
                for: indexPath
            ) as? BadgeTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        case .badgeCell(let model):
            model.handler()
        }
    }

}

