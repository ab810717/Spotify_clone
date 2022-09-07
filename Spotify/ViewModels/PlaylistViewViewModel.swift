//
//  PlaylistViewViewModel.swift
//  Spotify
//
//  Created by Andy Hao on 2022/9/6.
//

import Foundation
protocol PlaylistViewViewModelOutput: AnyObject {
    func updateUI()
    func updateUIAfterRemoveTrackFromPlaylist(indexPath: Int)
}
class PlaylistViewViewModel {
    let playlist: Playlist
    var recommendedTrackCellViewModels = [RecommendedTrackCellViewModel]()
    var tracks = [AudioTrack]()
    weak var delegate: PlaylistViewViewModelOutput?
    
    init(playlist: Playlist) {
        self.playlist = playlist
    }
    
    func fetchData() {
        APICaller.shared.getPlaylistsDetail(for: playlist) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success( let model):
                    self?.tracks = model.tracks.items.compactMap({ $0.track })
                    self?.recommendedTrackCellViewModels = model.tracks.items.compactMap({
                        RecommendedTrackCellViewModel(name: $0.track.name,
                                                      artristName: $0.track.artists.first?.name ?? "-" ,
                                                      artWorkURL: URL(string: $0.track.album?.images.first?.url ?? "" ))
                    })
                    self?.delegate?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func removeTrackFromplaylist(track:AudioTrack, playlist: Playlist,indexpath: Int) {
        APICaller.shared.removeTrackFromPlaylist(track: track, playlist: playlist) { success in
            if success {
                self.delegate?.updateUIAfterRemoveTrackFromPlaylist(indexPath: indexpath)
            } else {
                print("Failed to remove track from playlists")
            }
        }
    }
    
}
