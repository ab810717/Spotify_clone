//
//  SearchResult.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/10.
//

import Foundation
enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
