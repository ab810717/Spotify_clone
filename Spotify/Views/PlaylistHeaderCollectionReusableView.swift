//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/5.
//

import UIKit
import SDWebImage
protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playListHeaderDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    private let playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(playlistImageView)
        addSubview(playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = height / 1.8
        playlistImageView.setDimensions(height: imageSize, width: imageSize)
        playlistImageView.centerX(inView: self)
        playlistImageView.anchor(top: topAnchor, paddingTop: 20)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, ownerLabel])
        stack.axis = .vertical
        stack.spacing = 5
        addSubview(stack)
        stack.anchor(top: playlistImageView.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
        stack.setWidth(width * 8 / 10)
        playAllButton.anchor( bottom: bottomAnchor, right: rightAnchor, paddingBottom: 10, paddingRight: 10, width: 60, height: 60)
    }
    
    
    // MARK: - Helper functions
    func configure(with viewModel:PlaylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.description
        playlistImageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
    
    // MARK: - Actions
    @objc private func didTapPlayAll() {
        print("DEBUG: Did tapped button!")
        delegate?.playListHeaderDidTapPlayAll(self)
    }
}
