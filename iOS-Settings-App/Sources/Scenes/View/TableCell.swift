//
//  TableCell.swift
//  iOS-Settings-App
//

import UIKit

class TableCell: UITableViewCell {
    // MARK: - ID
    static let identifier = "TableCell"
    
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
        subLabel.text = nil
        iconContainer.backgroundColor = nil
    }
    
    // MARK: - Setup Hierarchy (Table)
    func setupHierarchy() {
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(label)
        contentView.addSubview(subLabel)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
    }
    
    // MARK: - Setup Layouts (Table)
    func setupLayouts() {
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
    
    // MARK: - Configure
    public func configure(with model: SettingsOption) {
        label.text = model.title
        subLabel.text = model.subText
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
    }
}
