//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import UIKit

class LibraryViewController: UIViewController {
    // MARK: - Properties
    private let playlistVC = LibraryPlaylistViewController()
    private let albumVC = LibraryAlbumsViewController()
    private let toggleView = LibraryToggleView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.addSubview(toggleView)
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        toggleView.delegate = self
        addChildren()
        updateBarButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    
    // MARK: - Helper functions
    private func updateBarButton() {
        switch toggleView.state {
        case .playlist:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        case .album:
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func configureUI() {
        scrollView.anchor(top:view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 55, width: view.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 55)
        scrollView.contentSize = CGSize(width: view.width * 2, height: scrollView.height)
        
        toggleView.anchor(top:view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, width: 200, height: 55)
        
    }
    
    private func addChildren() {
        addChild(playlistVC)
        scrollView.addSubview(playlistVC.view)
        playlistVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        playlistVC.didMove(toParent: self)
        
        addChild(albumVC)
        scrollView.addSubview(albumVC.view)
        albumVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumVC.didMove(toParent: self)
    }
    
    // MARK: - Actions
    @objc private func didTapAdd() {
        playlistVC.showCreatePlaylistAlert()
    }
    
}

// MARK: UIScrollViewDelegate
extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width-100) {
            toggleView.update(for: .album)
            updateBarButton()
        } else {
            toggleView.update(for: .playlist)
            updateBarButton()
        }
    }
}

extension LibraryViewController: LibraryToggleViewDelegate {
    func libraryToggleViewDidTapPlaylists(_ toggleview: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    func libraryToggleViewDidTapAlbums(_ toggleview: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x:view.width,y: 0), animated: true)
    }
    
    
}

