//
//  iOSSettingsAppView.swift
//  iOS-Settings-App
//
//  Created by Sergey Myzin on 28.11.2021.
//

import UIKit

class iOSSettingsAppView: UIView {
    // MARK: - Variables
    private var models = [Section]()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        
        table.register(TableCell.self,
                       forCellReuseIdentifier: TableCell.identifier)
        table.register(SwitchCell.self,
                       forCellReuseIdentifier: SwitchCell.identifier)
        table.register(BadgeCell.self,
                       forCellReuseIdentifier: BadgeCell.identifier)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    // MARK: - Init after load
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Configure functions
    public func configureView(with model: [Section]) {
        self.models = model
    }
    
    private func setupHierarchy() {
        addSubview(tableView)
    }
    
    private func setupLayouts() {
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension iOSSettingsAppView: UITableViewDelegate, UITableViewDataSource {
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
