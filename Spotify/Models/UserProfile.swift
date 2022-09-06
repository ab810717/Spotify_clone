//
//  UserProfile.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let displayName: String
    let email: String
    let explicitContent: [String:Bool]
    let externalUrls: [String:String]
    let id: String
    let product: String
    let images: [APIImage]
    
    enum CodingKeys: String, CodingKey {
        case country
        case email
        case id
        case product
        case images
        case displayName = "display_name"
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
    }
    
}


/*
 {
    country = TW;
    "display_name" = "\U90dd\U5fd7\U63da";
    email = "ab810717@gmail.com";
    "explicit_content" =     {
        "filter_enabled" = 0;
        "filter_locked" = 0;
    };
    "external_urls" =     {
        spotify = "https://open.spotify.com/user/31kvfa3lvlxx7q7ueobfj2xou2xa";
    };
    followers =     {
        href = "<null>";
        total = 1;
    };
    href = "https://api.spotify.com/v1/users/31kvfa3lvlxx7q7ueobfj2xou2xa";
    id = 31kvfa3lvlxx7q7ueobfj2xou2xa;
    images =     (
                {
            height = "<null>";
            url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=688305224559192&height=300&width=300&ext=1661504734&hash=AeTLWqN9cYlWSvJdK5c";
            width = "<null>";
        }
    );
    product = open;
    type = user;
    uri = "spotify:user:31kvfa3lvlxx7q7ueobfj2xou2xa";
}
 */
