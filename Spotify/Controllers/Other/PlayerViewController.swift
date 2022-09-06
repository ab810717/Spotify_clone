//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapFoward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
    func didTapClose()
    
}

class PlayerViewController: UIViewController {
    // MARK: - Properties
    weak var datasource: PlaybackPresenterDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Helper functinos
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, width: view.width, height: view.width)
        controlsView.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 10, width: view.width-20, height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15 )
        configureBarbuttons()
        controlsView.delegate = self
    }
    
    private func configureDataSource() {
        imageView.sd_setImage(with: datasource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewViewModel(title: datasource?.songName, subtitle: datasource?.subtitle))
    }
    
    private func configureBarbuttons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    func refreshUI() {
        configureDataSource()
    }
    
    
    // MARK: - Actions
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
        delegate?.didTapClose()
    }
    
    @objc func didTapAction() {
        
    }
    
    
}


// MARK: - PlayerContolsViewDelegate
extension PlayerViewController:PlayerContolsViewDelegate {
    func playerContorlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    func playerContorlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerContorlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapFoward()
    }
    
    func playerContorlsViewDidTapBackwordButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBackward()
    }
}
