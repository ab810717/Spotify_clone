//
//  Playlist.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import Foundation
struct Playlist: Codable {
    let description: String
    let externalUrls: [String:String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case description
        case externalUrls = "external_urls"
        case id
        case images
        case name
        case owner
    }
}
