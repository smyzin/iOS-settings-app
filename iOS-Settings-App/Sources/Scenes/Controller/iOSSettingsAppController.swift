//
//  iOSSettingsAppController.swift
//  SettingsApp2
//

import UIKit

class iOSSettingsAppController: UIViewController {
    // MARK: - Variables
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TableCell.self,
                       forCellReuseIdentifier: TableCell.identifier)
        table.register(SwitchCell.self,
                       forCellReuseIdentifier: SwitchCell.identifier)
        table.register(BadgeCell.self,
                       forCellReuseIdentifier: BadgeCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    // MARK: - Init after load
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
}

extension iOSSettingsAppController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    // MARK: - Configure table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TableCell.identifier,
                for: indexPath
            ) as? TableCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchCell.identifier,
                for: indexPath
            ) as? SwitchCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .badgeCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BadgeCell.identifier,
                for: indexPath
            ) as? BadgeCell else {
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

