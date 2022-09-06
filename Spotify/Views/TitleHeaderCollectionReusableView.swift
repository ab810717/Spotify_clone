//
//  TiitleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/6.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "TiitleHeaderCollectionReusableView"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.anchor(left: leftAnchor, paddingLeft: 10, width: width * 0.9, height: height)
        titleLabel.centerY(inView: self)
    }
    func configure(with title: String) {
        titleLabel.text = title
    }
}
