//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/9.
//

import Foundation
struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
