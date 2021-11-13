//
//  SettingTableViewCell.swift
//  iOS-Settings-App
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"
    
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
    
    private let subLabel: UILabel = {
        let subLabel = UILabel()
        subLabel.numberOfLines = Metrics.numberOfLines
        subLabel.textColor = .systemGray2
        subLabel.textAlignment = .right
        return subLabel
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(subLabel)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - Metrics.sizePadding
        iconContainer.frame = CGRect(x: Metrics.iconContainerX, y: Metrics.iconContainerY, width: size, height: size)
        
        let imageSize: CGFloat = size/1.5
        iconImageView.frame = CGRect(
            x: (size - imageSize)/2,
            y: (size - imageSize)/2,
            width: imageSize,
            height: imageSize
        )
        
        label.frame = CGRect(
            x: Metrics.labelXMargin + iconContainer.frame.size.width,
            y: Metrics.yZero,
            width: contentView.frame.size.width - Metrics.labelWidthMargin - iconContainer.frame.size.width,
            height: contentView.frame.size.height
        )
        
        subLabel.frame = CGRect(
            x: label.frame.size.width - Metrics.subLabelXMargin,
            y: Metrics.yZero,
            width: Metrics.subLabelWidth,
            height: contentView.frame.size.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subLabel.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsOption) {
        label.text = model.title
        subLabel.text = model.subText
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
    }
}
