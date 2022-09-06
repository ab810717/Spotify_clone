//
//  FeaturePlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/1.
//

import UIKit

class FeaturePlaylistCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    static let identifier = "FeaturePlaylistCollectionViewCell"
    private let playlistCoverImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playlistCoverImageview)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistNameLabel.sizeToFit()
        creatorNameLabel.sizeToFit()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageview.image = nil
    }
    
    // MARK: - Helpers
    private func configureUI() {
       
        let imageSize = contentView.height / 1.5
        playlistCoverImageview.setDimensions(height: imageSize, width: imageSize)
        playlistCoverImageview.centerX(inView: contentView)
        playlistCoverImageview.anchor(top: topAnchor, paddingTop: 10, width: imageSize, height: imageSize)
        
        let stack = UIStackView(arrangedSubviews: [playlistNameLabel,creatorNameLabel])
        stack.axis = .vertical
        contentView.addSubview(stack)
        stack.alignment = .fill
        stack.anchor(top: playlistCoverImageview.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 5)
    }
   
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text =  viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageview.sd_setImage(with: viewModel.artWorkURL, completed: nil)
    }
}
