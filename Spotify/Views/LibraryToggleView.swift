//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/24.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleview: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleview: LibraryToggleView)
    
}

class LibraryToggleView: UIView {
    // MARK: - Properties
    
    enum State {
        case playlist
        case album
    }
    var state: State = .playlist
    
    weak var delegate:LibraryToggleViewDelegate?
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlist", for: .normal)
        return button
    }()
    
    private let albumButton: UIButton = {
      let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Album", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumButton)
        addSubview(indicatorView)
        playlistButton.addTarget(self, action:#selector(didTapPlaylists), for: .touchUpInside)
        albumButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    
    // MARK: - Helper functions
    private func configureUI() {

        playlistButton.anchor(top:topAnchor, left: leftAnchor, width: 100, height: 40)
        albumButton.anchor(top:topAnchor, left: playlistButton.rightAnchor, paddingLeft: 0, width: 100, height: 40)
        layoutIndicator()
    }
    
    private func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playlistButton.bottom, width: 100, height: 3)
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.25) {
            self.layoutIndicator()
        }
    }
    
    // MARK: - Actions
    @objc func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.25) {
            self.layoutIndicator()
            self.layoutIfNeeded()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc func didTapAlbums(){
        state = .album
        UIView.animate(withDuration: 0.25) {
            self.layoutIndicator()
            self.layoutIfNeeded()
        }
        
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
}
