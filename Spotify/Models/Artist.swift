//
//  Artist.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import Foundation
struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let externalUrls: [String: String]
    let images: [APIImage]?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case images
        case externalUrls = "external_urls"
    }
}
