//
//  AuthResponse.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/26.
//

import Foundation
/*
 {
 "access_token" = "BQCkAvf9BJGJyi7ZQ5gkcPQ6j0_08MjsAxyQVYSAkHZd5_objku2kwfymW29qDelV7jX9QdZEH3V-GS6MNzs2IFy47ztO_L3p_ul62Vr7hRhXb_9S6AEUzLiC443smySrMsIs7gAnOPZlxIfzbvySgVSiZcUz1G99K-I8L6Kxw1JHFVboRH9Xw9Ww9vuer7jzOIPalX7FVeITXA0seE";
 "expires_in" = 3600;
 "refresh_token" = "AQCtHq1gOATncIwuuquggr5zFJl4amTHC5M_USyl0hdmNC4sZ8BC0-NX6AtAp2qIGAfEZdqUFyRSt8cPRhyhnQo931-uuO7pk4hDJ_qBs3tBI7Lv6dl6kb37latideOGu7I";
 scope = "user-read-private";
 "token_type" = Bearer;
 }
 */

struct AuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case scope
        case tokenType = "token_type"
    }
    
}
