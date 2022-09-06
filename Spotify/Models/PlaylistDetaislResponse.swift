//
//  PlaylistDetailResponse.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/3.
//

import Foundation

struct PlaylistDetailsResponse: Codable  {
    let description: String
    let externalUrls: [String:String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracksResponse
    
    enum CodingKeys: String, CodingKey {
        case description
        case externalUrls = "external_urls"
        case id
        case images
        case name
        case tracks
    }
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
