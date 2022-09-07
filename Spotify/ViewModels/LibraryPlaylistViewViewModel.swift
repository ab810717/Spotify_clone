//
//  LibraryPlaylistViewViewModel.swift
//  Spotify
//
//  Created by Andy Hao on 2022/9/6.
//

import Foundation

protocol LibraryPlaylistViewViewModelOutput: AnyObject {
    func updateUI()
}

class LibraryPlaylistViewViewModel {
    var playlists = [Playlist]()
    weak var delegate:LibraryPlaylistViewViewModelOutput?
    func fetchData() {
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.delegate?.updateUI()
                case .failure(let error):
                    print("Get an error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func createPlaylist(with text:String) {
        APICaller.shared.createPlaylist(with: text) { success in
            if success {
                self.fetchData()
                print("Create playlist successfully!")
            } else {
                print("Failed to create playlist")
            }
        }
    }
}

