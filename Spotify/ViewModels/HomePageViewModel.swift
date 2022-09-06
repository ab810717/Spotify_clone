//
//  HomePageViewModel.swift
//  Spotify
//
//  Created by Andy Hao on 2022/9/6.
//

import Foundation
protocol HomePageViewModelOutput: AnyObject {
    func updateUI()
    func loadingUI()
}

enum BrowseSectionType {
    case newReleases(viewModels: [NewReleasesCellViewModel])
    case featuredPlaylists(viewModels: [FeaturedPlaylistCellViewModel])
    case recommendedTracks(viewModels: [RecommendedTrackCellViewModel])
    var title: String {
        switch self {
        case .newReleases:
            return "New Released Albums"
        case .featuredPlaylists:
            return "Featured Playlists"
        case .recommendedTracks:
            return "Recommended"
        }
    }
}

class HomePageViewModel {
    var newAlbums: [Album] = []
    var playlists: [Playlist] = []
    var tracks: [AudioTrack] = []
    var sections = [BrowseSectionType]()
    weak var delegate: HomePageViewModelOutput?
    
    func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        print("DEBUG: Start fetching data...")
        self.delegate?.loadingUI()
        var newReleaseResponse: NewReleasesResponse?
        var featurePlayList: FeaturedPlayListsResponse?
        var recommendations: RecommendationsResponse?
        // New Releases
        APICaller.shared.getNewReleases { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                newReleaseResponse = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // Featured Playlist,
        APICaller.shared.getFeaturePlayLists { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                featurePlayList = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // Recommended Tracks
        APICaller.shared.getRecommendationGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
                    defer {
                        group.leave()
                    }
                    switch recommendedResult {
                    case .success(let model):
                        recommendations = model
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print("DEBUG: Get error: \(error.localizedDescription)")
            }
        }
        group.notify(queue: .main) {
            guard let newAlbum = newReleaseResponse?.albums.items,
                  let playlists = featurePlayList?.playlists.items,
                  let tracks = recommendations?.tracks else {
                print("DEBuG: Models are nil" )
                return
            }
            print("DEBUG: All tasks done!")
            self.configureModels(newAlbums: newAlbum, playlists: playlists, tracks: tracks)
        }
        
        
    }
    
    private func configureModels(newAlbums:[Album], playlists:[Playlist], tracks:[AudioTrack]) {
        // Configure Models
        self.newAlbums = newAlbums
        self.playlists = playlists
        self.tracks = tracks
        sections.append(.newReleases(viewModels: newAlbums.compactMap({
            return NewReleasesCellViewModel(name: $0.name, artWorkURL: URL(string: $0.images.first?.url ?? "" ), numberOfTrack: $0.totalTracks, artistName: $0.artists.first?.name ?? "-")
        })))
        sections.append(.featuredPlaylists(viewModels: playlists.compactMap({
            return FeaturedPlaylistCellViewModel(name: $0.name, artWorkURL: URL(string: $0.images.first?.url ?? "" ), creatorName: $0.owner.displayName)
        })))
        sections.append(.recommendedTracks(viewModels: tracks.compactMap({
            return RecommendedTrackCellViewModel(name: $0.name, artristName: $0.artists.first?.name ?? "" , artWorkURL: URL(string: $0.album?.images.first?.url ?? ""))
        })))
        self.delegate?.updateUI()
    }
    
}
