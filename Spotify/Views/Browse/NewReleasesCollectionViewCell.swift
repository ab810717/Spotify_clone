//
//  NewReleasesCollectionViewCell.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/1.
//

import UIKit
import SDWebImage
class NewReleasesCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let idenfifier = "NewReleasesCollectionViewCell"
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label 
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumLabel.sizeToFit()
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    // MARK: - Helpers
    private func configureUI() {
        albumCoverImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 5)
        let imageSize = contentView.height - 10
        albumCoverImageView.setDimensions(height: imageSize, width: imageSize)
   
        let stack = UIStackView(arrangedSubviews: [albumLabel, artistNameLabel,numberOfTracksLabel])
        stack.axis = .vertical
        
        
        contentView.addSubview(stack)
        stack.anchor(top: topAnchor, left: albumCoverImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 5)
        
    }
   
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTrack)"
        albumCoverImageView.sd_setImage(with: viewModel.artWorkURL, completed: nil)
    }
}
