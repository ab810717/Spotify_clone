//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/17.
//

import Foundation
import UIKit

protocol PlayerContolsViewDelegate: AnyObject {
    func playerContorlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerContorlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerContorlsViewDidTapBackwordButton(_ playerControlsView: PlayerControlsView)
    func playerContorlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView {
    // MARK: - Properties
    
    private var isPlaying = true
    weak var delegate: PlayerContolsViewDelegate?
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "This is My Song"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Drake (feat. Some Other Arties)"
        return label
    }()
    
    private let backButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.anchor(top: topAnchor, left: leftAnchor ,width: width, height: 50)
        subtitleLabel.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 0, width: width, height: 50)
        volumeSlider.anchor(top: subtitleLabel.bottomAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 10, width: width - 20, height: 44)
        
        let buttonSize: CGFloat = 40
        playPauseButton.anchor(top: volumeSlider.bottomAnchor, left: leftAnchor, paddingTop: 30, paddingLeft: (width - buttonSize) / 2, width: buttonSize, height: buttonSize)
        
        backButton.anchor(top:playPauseButton.topAnchor, right: playPauseButton.leftAnchor, paddingRight: 80, width: buttonSize, height: buttonSize)
        nextButton.anchor(top: playPauseButton.topAnchor, left: playPauseButton.rightAnchor, paddingLeft: 80, width: buttonSize, height: buttonSize)
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(playPauseButton)
        
        clipsToBounds = true
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)   ), for: .valueChanged)
    }
    
    func configure(with viewModel: PlayerControlsViewViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
    // MARK: - Actions
    @objc private func didTapBack() {
        delegate?.playerContorlsViewDidTapBackwordButton(self)
    }
    
    @objc private func didTapPlayPause() {
        self.isPlaying = !isPlaying
        delegate?.playerContorlsViewDidTapPlayPauseButton(self)
        
        // Update icon
        let pause = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    @objc private func didTapNext() {
        delegate?.playerContorlsViewDidTapForwardButton(self)
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        delegate?.playerContorlsView(self, didSlideSlider: value)
    }
    
}
