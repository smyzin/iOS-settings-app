//
//  iOSSettingsAppController.swift
//  iOS-Settings-App
//

import UIKit

class iOSSettingsAppController: UIViewController {
    // MARK: - Variables
    var models: iOSSettingsAppModel?
    private var tableView: iOSSettingsAppView? {
        guard isViewLoaded else { return nil }
        return view as? iOSSettingsAppView
    }
    
    // MARK: - Init after load
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view = iOSSettingsAppView()
        models = iOSSettingsAppModel()
        configureView()
    }
}

// MARK: - Configure
private extension iOSSettingsAppController {
    func configureView() {
        guard let models = models?.configure() else { return }
        tableView?.configureView(with: models)
    }
}

