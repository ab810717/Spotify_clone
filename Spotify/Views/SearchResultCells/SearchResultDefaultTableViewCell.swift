//
//  SearchResultDefaultTableViewCell.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/11.
//

import UIKit
import SDWebImage


class SearchResultDefaultTableViewCell: UITableViewCell {
    static let identifier = "SearchResultDefaultTableViewCell"
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    // MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)   
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - Helpers function
    func configureUI() {
        
        let imageSize = contentView.height * 0.8
        iconImageView.layer.cornerRadius = imageSize / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.setDimensions(height: imageSize, width: imageSize)
        iconImageView.centerY(inView: contentView)
        iconImageView.anchor(left: leftAnchor, paddingLeft: 10)
        
        titleLabel.setDimensions(height: imageSize, width: contentView.width * 0.8)
        titleLabel.centerY(inView: contentView)
        titleLabel.anchor(left: iconImageView.rightAnchor, paddingLeft: 10)
    }
    
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        iconImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
    }
}
