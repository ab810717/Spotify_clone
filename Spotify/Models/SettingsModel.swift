//
//  SettingsModel.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/27.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
