//
//  SwitchCell.swift
//  iOS-Settings-App
//

import UIKit

class SwitchCell: UITableViewCell {
    // MARK: - ID
    static let identifier = "SwitchCell"
    
    // MARK: - Variables
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = Metrics.cornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = Metrics.numberOfLines
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let _switch: UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = .systemGreen
        return _switch
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayouts()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
        _switch.isOn = false
    }
    
    // MARK: - Setup Hierarchy (Switch)
    func setupHierarchy() {
        contentView.clipsToBounds = true
        accessoryType = .none
        
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(_switch)
        iconContainer.addSubview(iconImageView)
    }
    
    // MARK: - Setup Layouts (Switch)
    func setupLayouts() {
        let size: CGFloat = contentView.frame.size.height - Metrics.sizePadding
        iconContainer.frame = CGRect(x: Metrics.iconContainerX, y: Metrics.iconContainerY, width: size, height: size)
        
        let imageSize: CGFloat = size/1.5
        iconImageView.frame = CGRect(x: (size - imageSize)/2, y: (size - imageSize)/2, width: imageSize, height: imageSize)
        
        _switch.sizeToFit()
        _switch.frame = CGRect(
            x: contentView.frame.size.width - _switch.frame.size.width - Metrics.switchXMargin,
            y: (contentView.frame.size.height - _switch.frame.size.height)/2,
            width: _switch.frame.size.width,
            height: _switch.frame.size.height)
        
        label.frame = CGRect(
            x: Metrics.labelXMargin + iconContainer.frame.size.width,
            y: Metrics.yZero,
            width: contentView.frame.size.width - Metrics.labelWidthMargin - iconContainer.frame.size.width,
            height: contentView.frame.size.height)
    }
    
    // MARK: - Configure
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        _switch.isOn = model.isOn
    }
}
