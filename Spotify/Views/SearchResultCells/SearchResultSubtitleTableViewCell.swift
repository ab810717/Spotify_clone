//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/12.
//

import Foundation
import UIKit
import SDWebImage


class SearchResultSubtitleTableViewCell: UITableViewCell {
    static let identifier = "SearchResultSubtitleTableViewCell"
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
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
        contentView.addSubview(subtitleLabel)
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
        subtitleLabel.text = nil
    }
    
    // MARK: - Helpers function
    func configureUI () {
        let imageSize = contentView.height * 0.8
    
        iconImageView.setDimensions(height: imageSize, width: imageSize)
        iconImageView.layer.cornerRadius = imageSize / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 5, width: imageSize, height: imageSize)
        
        let labelHeight = contentView.height / 2
        titleLabel.anchor(top: topAnchor, left: iconImageView.rightAnchor, paddingLeft: 10)
        titleLabel.setDimensions(height: labelHeight, width: contentView.width * 0.8)

        subtitleLabel.anchor(top: titleLabel.bottomAnchor, left: iconImageView.rightAnchor, paddingLeft: 10)
        subtitleLabel.setDimensions(height: labelHeight, width: contentView.width * 0.8)
    }
    
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
}
