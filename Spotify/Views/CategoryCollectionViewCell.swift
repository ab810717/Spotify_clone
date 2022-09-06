//
//  GenreCollectionViewCell .swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/8.
//

import Foundation
import UIKit
import SDWebImage
class CategoryCollectionViewCell : UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.tintColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemPurple,
        .systemOrange,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .darkGray,
        .systemTeal
    ]
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPurple
        contentView.layer.contents = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        titleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: contentView.height / 2, paddingLeft: 10)
        titleLabel.setDimensions(height: contentView.height/2 , width: contentView.width - 20)
        imageView.anchor(top:topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: contentView.width / 2 )
        imageView.setDimensions(height: contentView.height / 2 , width: contentView.width / 2)
    }
    
    // MARK: - Helper function
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
}
