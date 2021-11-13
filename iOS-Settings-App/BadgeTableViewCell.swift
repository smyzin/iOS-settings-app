//
//  BadgeTableViewCell.swift
//  iOS-Settings-App
//
//  Created by Sergey Myzin on 13.11.2021.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {
    static let identifier = "BadgeTableViewCell"
    
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
    private let badge: UILabel = {
        let badge = UILabel()
        badge.numberOfLines = Metrics.numberOfLines
        badge.textColor = .white
        badge.backgroundColor = .systemRed
        badge.textAlignment = .center
        badge.layer.masksToBounds = true
        badge.layer.cornerRadius = Metrics.cornerRadius
        return badge
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
        contentView.addSubview(label)
        contentView.addSubview(badge)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup layout
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
            y: 0,
            width: contentView.frame.size.width - Metrics.labelWidthMargin - iconContainer.frame.size.width,
            height: contentView.frame.size.height
        )
        
        badge.frame = CGRect(
            x: label.frame.size.width + Metrics.badgeXMargin,
            y: label.frame.size.height - Metrics.badgeYMargin,
            width: Metrics.badgeWidth,
            height: Metrics.badgeHeight
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        badge.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsBadgeOption) {
        label.text = model.title
        badge.text = model.count
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
    }

    // MARK: -Default
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
