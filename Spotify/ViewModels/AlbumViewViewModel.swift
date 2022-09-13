//
//  AlbumViewViewModel.swift
//  Spotify
//
//  Created by Andy Hao on 2022/9/6.
//

import Foundation

protocol AlbumViewViewModelOutput: AnyObject {
    func updateUI()
}

class AlbumViewViewModel {
    let album:Album
    weak var delegate: AlbumViewViewModelOutput?
    var tracks = [AudioTrack]()
    var albumCollectionViewCellViewModel = [AlbumCollectionViewCellViewModel]()
    
    init(album: Album) {
        self.album = album
    }
    
    func fetchData() {
        APICaller.shared.getAlbumDetails(for: album) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let model):
                    self?.tracks = model.tracks.items
                    self?.albumCollectionViewCellViewModel = model.tracks.items.compactMap({
                        AlbumCollectionViewCellViewModel(
                            name: $0.name,
                            artristName: $0.artists.first?.name ?? "-"
                        )
                    })
                    self?.delegate?.updateUI()
                    print("Get model")
                case .failure(let error):
                    print("DEBUG: Get an error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func saveAlbum() {
        APICaller.shared.saveAlbum(album: album) { success in
            print("saveAlbum: \(success)")
            if success {
                NotificationCenter.default.post(name: .albumSaveNotification, object: nil)
            }
        }
    }
    
}
