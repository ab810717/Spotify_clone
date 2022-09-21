//
//  AudioTrack.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import Foundation
struct AudioTrack: Codable {
    var album: Album?
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalUrls: [String:String]
    let id: String
    let name: String
    let popularity: Int?
    let previewURL: String?
    
    enum CodingKeys: String, CodingKey {
        case album
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMs = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case id
        case name
        case popularity
        case previewURL = "preview_url"
    }
}

extension AudioTrack {
    init(with prewviewURL: String) {
        self.album = nil
        self.artists = []
        self.availableMarkets = []
        self.discNumber = 0
        self.durationMs = 0
        self.explicit = false
        self.externalUrls = [:]
        self.id = ""
        self.name = ""
        self.popularity = 0
        self.previewURL = prewviewURL
    }
}
