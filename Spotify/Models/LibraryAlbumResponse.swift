//
//  LibraryAlbumResponse.swift
//  Spotify
//
//  Created by Andy Hao on 2022/9/8.
//

import Foundation
struct LibraryAlbumResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let album: Album
    let addedAt:String
    enum CodingKeys: String, CodingKey {
        case album
        case addedAt = "added_at"
    }
}
