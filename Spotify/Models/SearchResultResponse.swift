//
//  SearchResultResponse.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/10.
//

import Foundation
struct SearchResultResponse: Codable {
    let albums: SerachAlbumResponse
    let artists: SearchArtistResponse
    let playlists: SearchPlaylistsResponse
    let tracks: SearchTrackResponse
}

struct SerachAlbumResponse: Codable {
    let items: [Album]
}

struct SearchArtistResponse: Codable {
    let items: [Artist]
}

struct SearchPlaylistsResponse: Codable {
    let items: [Playlist]
}

struct SearchTrackResponse: Codable {
    let items: [AudioTrack]
}

