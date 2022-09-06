//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/1.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    // MARK: - Properties
    private let albumCoverImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageview)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackNameLabel.sizeToFit()
        artistNameLabel.sizeToFit()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageview.image = nil
    }
    
    // MARK: - Helpers
    private func configureUI() {
        let imageSize = contentView.height-4
        albumCoverImageview.anchor(top: topAnchor, left: leftAnchor, paddingTop: 2, paddingLeft: 5, width: imageSize, height: imageSize)
        let stack = UIStackView(arrangedSubviews: [trackNameLabel, artistNameLabel])
        stack.axis = .vertical
        contentView.addSubview(stack)
        stack.anchor(top: topAnchor, left: albumCoverImageview.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
    }
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text =  viewModel.name
        artistNameLabel.text = viewModel.artristName
        albumCoverImageview.sd_setImage(with: viewModel.artWorkURL, completed: nil)
    }
}
