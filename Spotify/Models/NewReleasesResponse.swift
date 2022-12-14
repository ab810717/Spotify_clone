//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/29.
//

import Foundation
struct NewReleasesResponse: Codable {
    let albums: AlbumResponse
}

struct AlbumResponse: Codable {
    let items: [Album]
}


struct Album: Codable {
    let albumType: String
    let availableMarkets: [String]
    let artists: [Artist]
    let id: String
    var images:[APIImage]
    let name: String
    let releaseDate: String
    let totalTracks: Int
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case artists
        case id
        case images
        case name
        case releaseDate = "release_date"
        case totalTracks = "total_tracks"
    }
}



/*
 {
     "albums": {
         "href": "https://api.spotify.com/v1/browse/new-releases?offset=0&limit=2",
         "items": [
             {
                 "album_type": "album",
                 "artists": [
                     {
                         "external_urls": {
                             "spotify": "https://open.spotify.com/artist/6vWDO969PvNqNYHIOW5v0m"
                         },
                         "href": "https://api.spotify.com/v1/artists/6vWDO969PvNqNYHIOW5v0m",
                         "id": "6vWDO969PvNqNYHIOW5v0m",
                         "name": "Beyoncé",
                         "type": "artist",
                         "uri": "spotify:artist:6vWDO969PvNqNYHIOW5v0m"
                     }
                 ],
                 "available_markets": [
                     "TO",
                     "WS",
                     "FJ",
                     "KI",
                     "MH",
                     "NR",
                     "NZ",
                     "TV",
                     "FM",
                     "SB",
                     "VU",
                     "AU",
                     "PG",
                     "JP",
                     "KR",
                     "PW",
                     "TL",
                     "BN",
                     "HK",
                     "MN",
                     "MO",
                     "MY",
                     "PH",
                     "SG",
                     "TW",
                     "ID",
                     "KH",
                     "LA",
                     "TH",
                     "VN",
                     "BD",
                     "BT",
                     "KG",
                     "KZ",
                     "NP",
                     "IN",
                     "LK",
                     "MV",
                     "PK",
                     "TJ",
                     "UZ",
                     "AE",
                     "AM",
                     "AZ",
                     "GE",
                     "MU",
                     "OM",
                     "SC",
                     "BG",
                     "BH",
                     "BY",
                     "CY",
                     "DJ",
                     "EE",
                     "FI",
                     "GR",
                     "IL",
                     "IQ",
                     "JO",
                     "KE",
                     "KM",
                     "KW",
                     "LB",
                     "LT",
                     "LV",
                     "MD",
                     "MG",
                     "PS",
                     "QA",
                     "RO",
                     "SA",
                     "TR",
                     "TZ",
                     "UA",
                     "UG",
                     "AD",
                     "AL",
                     "AT",
                     "BA",
                     "BE",
                     "BI",
                     "BW",
                     "CH",
                     "CZ",
                     "DE",
                     "DK",
                     "EG",
                     "ES",
                     "FR",
                     "HR",
                     "HU",
                     "IT",
                     "LI",
                     "LS",
                     "LU",
                     "LY",
                     "MC",
                     "ME",
                     "MK",
                     "MT",
                     "MW",
                     "MZ",
                     "NA",
                     "NL",
                     "NO",
                     "PL",
                     "RS",
                     "RW",
                     "SE",
                     "SI",
                     "SK",
                     "SM",
                     "SZ",
                     "XK",
                     "ZA",
                     "ZM",
                     "ZW",
                     "AO",
                     "BJ",
                     "CD",
                     "CG",
                     "CM",
                     "DZ",
                     "GA",
                     "GB",
                     "GQ",
                     "IE",
                     "MA",
                     "NE",
                     "NG",
                     "PT",
                     "TD",
                     "TN",
                     "BF",
                     "CI",
                     "GH",
                     "GM",
                     "GN",
                     "GW",
                     "IS",
                     "LR",
                     "ML",
                     "MR",
                     "SL",
                     "SN",
                     "ST",
                     "TG",
                     "CV",
                     "AR",
                     "BR",
                     "SR",
                     "UY",
                     "AG",
                     "BB",
                     "BO",
                     "BS",
                     "CA",
                     "CL",
                     "CW",
                     "DM",
                     "DO",
                     "GD",
                     "GY",
                     "HT",
                     "KN",
                     "LC",
                     "PY",
                     "TT",
                     "US",
                     "VC",
                     "VE",
                     "CO",
                     "EC",
                     "JM",
                     "MX",
                     "PA",
                     "PE",
                     "BZ",
                     "CR",
                     "GT",
                     "HN",
                     "NI",
                     "SV"
                 ],
                 "external_urls": {
                     "spotify": "https://open.spotify.com/album/6FJxoadUE4JNVwWHghBwnb"
                 },
                 "href": "https://api.spotify.com/v1/albums/6FJxoadUE4JNVwWHghBwnb",
                 "id": "6FJxoadUE4JNVwWHghBwnb",
                 "images": [
                     {
                         "height": 640,
                         "url": "https://i.scdn.co/image/ab67616d0000b2730e58a0f8308c1ad403d105e7",
                         "width": 640
                     },
                     {
                         "height": 300,
                         "url": "https://i.scdn.co/image/ab67616d00001e020e58a0f8308c1ad403d105e7",
                         "width": 300
                     },
                     {
                         "height": 64,
                         "url": "https://i.scdn.co/image/ab67616d000048510e58a0f8308c1ad403d105e7",
                         "width": 64
                     }
                 ],
                 "name": "RENAISSANCE",
                 "release_date": "2022-07-29",
                 "release_date_precision": "day",
                 "total_tracks": 16,
                 "type": "album",
                 "uri": "spotify:album:6FJxoadUE4JNVwWHghBwnb"
             },
             {
                 "album_type": "single",
                 "artists": [
                     {
                         "external_urls": {
                             "spotify": "https://open.spotify.com/artist/7ltDVBr6mKbRvohxheJ9h1"
                         },
                         "href": "https://api.spotify.com/v1/artists/7ltDVBr6mKbRvohxheJ9h1",
                         "id": "7ltDVBr6mKbRvohxheJ9h1",
                         "name": "ROSALÍA",
                         "type": "artist",
                         "uri": "spotify:artist:7ltDVBr6mKbRvohxheJ9h1"
                     }
                 ],
                 "available_markets": [
                     "AD",
                     "AE",
                     "AG",
                     "AL",
                     "AM",
                     "AO",
                     "AR",
                     "AT",
                     "AU",
                     "AZ",
                     "BA",
                     "BB",
                     "BD",
                     "BE",
                     "BF",
                     "BG",
                     "BH",
                     "BI",
                     "BJ",
                     "BN",
                     "BO",
                     "BR",
                     "BS",
                     "BT",
                     "BW",
                     "BY",
                     "BZ",
                     "CA",
                     "CD",
                     "CG",
                     "CH",
                     "CI",
                     "CL",
                     "CM",
                     "CO",
                     "CR",
                     "CV",
                     "CW",
                     "CY",
                     "CZ",
                     "DE",
                     "DJ",
                     "DK",
                     "DM",
                     "DO",
                     "DZ",
                     "EC",
                     "EE",
                     "EG",
                     "ES",
                     "FI",
                     "FJ",
                     "FM",
                     "FR",
                     "GA",
                     "GB",
                     "GD",
                     "GE",
                     "GH",
                     "GM",
                     "GN",
                     "GQ",
                     "GR",
                     "GT",
                     "GW",
                     "GY",
                     "HK",
                     "HN",
                     "HR",
                     "HT",
                     "HU",
                     "ID",
                     "IE",
                     "IL",
                     "IN",
                     "IQ",
                     "IS",
                     "IT",
                     "JM",
                     "JO",
                     "JP",
                     "KE",
                     "KG",
                     "KH",
                     "KI",
                     "KM",
                     "KN",
                     "KR",
                     "KW",
                     "KZ",
                     "LA",
                     "LB",
                     "LC",
                     "LI",
                     "LK",
                     "LR",
                     "LS",
                     "LT",
                     "LU",
                     "LV",
                     "LY",
                     "MA",
                     "MC",
                     "MD",
                     "ME",
                     "MG",
                     "MH",
                     "MK",
                     "ML",
                     "MN",
                     "MO",
                     "MR",
                     "MT",
                     "MU",
                     "MV",
                     "MW",
                     "MX",
                     "MY",
                     "MZ",
                     "NA",
                     "NE",
                     "NG",
                     "NI",
                     "NL",
                     "NO",
                     "NP",
                     "NR",
                     "NZ",
                     "OM",
                     "PA",
                     "PE",
                     "PG",
                     "PH",
                     "PK",
                     "PL",
                     "PS",
                     "PT",
                     "PW",
                     "PY",
                     "QA",
                     "RO",
                     "RS",
                     "RW",
                     "SA",
                     "SB",
                     "SC",
                     "SE",
                     "SG",
                     "SI",
                     "SK",
                     "SL",
                     "SM",
                     "SN",
                     "SR",
                     "ST",
                     "SV",
                     "SZ",
                     "TD",
                     "TG",
                     "TH",
                     "TJ",
                     "TL",
                     "TN",
                     "TO",
                     "TR",
                     "TT",
                     "TV",
                     "TW",
                     "TZ",
                     "UA",
                     "UG",
                     "US",
                     "UY",
                     "UZ",
                     "VC",
                     "VE",
                     "VN",
                     "VU",
                     "WS",
                     "XK",
                     "ZA",
                     "ZM",
                     "ZW"
                 ],
                 "external_urls": {
                     "spotify": "https://open.spotify.com/album/5omNd3Mkij9C3ZeW19rRmv"
                 },
                 "href": "https://api.spotify.com/v1/albums/5omNd3Mkij9C3ZeW19rRmv",
                 "id": "5omNd3Mkij9C3ZeW19rRmv",
                 "images": [
                     {
                         "height": 640,
                         "url": "https://i.scdn.co/image/ab67616d0000b2738f072024e0358fc5c62eba41",
                         "width": 640
                     },
                     {
                         "height": 300,
                         "url": "https://i.scdn.co/image/ab67616d00001e028f072024e0358fc5c62eba41",
                         "width": 300
                     },
                     {
                         "height": 64,
                         "url": "https://i.scdn.co/image/ab67616d000048518f072024e0358fc5c62eba41",
                         "width": 64
                     }
                 ],
                 "name": "DESPECHÁ",
                 "release_date": "2022-07-28",
                 "release_date_precision": "day",
                 "total_tracks": 1,
                 "type": "album",
                 "uri": "spotify:album:5omNd3Mkij9C3ZeW19rRmv"
             }
         ],
         "limit": 2,
         "next": "https://api.spotify.com/v1/browse/new-releases?offset=2&limit=2",
         "offset": 0,
         "previous": null,
         "total": 100
     }
 }{
 "albums": {
     "href": "https://api.spotify.com/v1/browse/new-releases?offset=0&limit=2",
     "items": [
         {
             "album_type": "album",
             "artists": [
                 {
                     "external_urls": {
                         "spotify": "https://open.spotify.com/artist/6vWDO969PvNqNYHIOW5v0m"
                     },
                     "href": "https://api.spotify.com/v1/artists/6vWDO969PvNqNYHIOW5v0m",
                     "id": "6vWDO969PvNqNYHIOW5v0m",
                     "name": "Beyoncé",
                     "type": "artist",
                     "uri": "spotify:artist:6vWDO969PvNqNYHIOW5v0m"
                 }
             ],
             "available_markets": [
                 "TO",
                 "WS",
                 "FJ",
                 "KI",
                 "MH",
                 "NR",
                 "NZ",
                 "TV",
                 "FM",
                 "SB",
                 "VU",
                 "AU",
                 "PG",
                 "JP",
                 "KR",
                 "PW",
                 "TL",
                 "BN",
                 "HK",
                 "MN",
                 "MO",
                 "MY",
                 "PH",
                 "SG",
                 "TW",
                 "ID",
                 "KH",
                 "LA",
                 "TH",
                 "VN",
                 "BD",
                 "BT",
                 "KG",
                 "KZ",
                 "NP",
                 "IN",
                 "LK",
                 "MV",
                 "PK",
                 "TJ",
                 "UZ",
                 "AE",
                 "AM",
                 "AZ",
                 "GE",
                 "MU",
                 "OM",
                 "SC",
                 "BG",
                 "BH",
                 "BY",
                 "CY",
                 "DJ",
                 "EE",
                 "FI",
                 "GR",
                 "IL",
                 "IQ",
                 "JO",
                 "KE",
                 "KM",
                 "KW",
                 "LB",
                 "LT",
                 "LV",
                 "MD",
                 "MG",
                 "PS",
                 "QA",
                 "RO",
                 "SA",
                 "TR",
                 "TZ",
                 "UA",
                 "UG",
                 "AD",
                 "AL",
                 "AT",
                 "BA",
                 "BE",
                 "BI",
                 "BW",
                 "CH",
                 "CZ",
                 "DE",
                 "DK",
                 "EG",
                 "ES",
                 "FR",
                 "HR",
                 "HU",
                 "IT",
                 "LI",
                 "LS",
                 "LU",
                 "LY",
                 "MC",
                 "ME",
                 "MK",
                 "MT",
                 "MW",
                 "MZ",
                 "NA",
                 "NL",
                 "NO",
                 "PL",
                 "RS",
                 "RW",
                 "SE",
                 "SI",
                 "SK",
                 "SM",
                 "SZ",
                 "XK",
                 "ZA",
                 "ZM",
                 "ZW",
                 "AO",
                 "BJ",
                 "CD",
                 "CG",
                 "CM",
                 "DZ",
                 "GA",
                 "GB",
                 "GQ",
                 "IE",
                 "MA",
                 "NE",
                 "NG",
                 "PT",
                 "TD",
                 "TN",
                 "BF",
                 "CI",
                 "GH",
                 "GM",
                 "GN",
                 "GW",
                 "IS",
                 "LR",
                 "ML",
                 "MR",
                 "SL",
                 "SN",
                 "ST",
                 "TG",
                 "CV",
                 "AR",
                 "BR",
                 "SR",
                 "UY",
                 "AG",
                 "BB",
                 "BO",
                 "BS",
                 "CA",
                 "CL",
                 "CW",
                 "DM",
                 "DO",
                 "GD",
                 "GY",
                 "HT",
                 "KN",
                 "LC",
                 "PY",
                 "TT",
                 "US",
                 "VC",
                 "VE",
                 "CO",
                 "EC",
                 "JM",
                 "MX",
                 "PA",
                 "PE",
                 "BZ",
                 "CR",
                 "GT",
                 "HN",
                 "NI",
                 "SV"
             ],
             "external_urls": {
                 "spotify": "https://open.spotify.com/album/6FJxoadUE4JNVwWHghBwnb"
             },
             "href": "https://api.spotify.com/v1/albums/6FJxoadUE4JNVwWHghBwnb",
             "id": "6FJxoadUE4JNVwWHghBwnb",
             "images": [
                 {
                     "height": 640,
                     "url": "https://i.scdn.co/image/ab67616d0000b2730e58a0f8308c1ad403d105e7",
                     "width": 640
                 },
                 {
                     "height": 300,
                     "url": "https://i.scdn.co/image/ab67616d00001e020e58a0f8308c1ad403d105e7",
                     "width": 300
                 },
                 {
                     "height": 64,
                     "url": "https://i.scdn.co/image/ab67616d000048510e58a0f8308c1ad403d105e7",
                     "width": 64
                 }
             ],
             "name": "RENAISSANCE",
             "release_date": "2022-07-29",
             "release_date_precision": "day",
             "total_tracks": 16,
             "type": "album",
             "uri": "spotify:album:6FJxoadUE4JNVwWHghBwnb"
         },
         {
             "album_type": "single",
             "artists": [
                 {
                     "external_urls": {
                         "spotify": "https://open.spotify.com/artist/7ltDVBr6mKbRvohxheJ9h1"
                     },
                     "href": "https://api.spotify.com/v1/artists/7ltDVBr6mKbRvohxheJ9h1",
                     "id": "7ltDVBr6mKbRvohxheJ9h1",
                     "name": "ROSALÍA",
                     "type": "artist",
                     "uri": "spotify:artist:7ltDVBr6mKbRvohxheJ9h1"
                 }
             ],
             "available_markets": [
                 "AD",
                 "AE",
                 "AG",
                 "AL",
                 "AM",
                 "AO",
                 "AR",
                 "AT",
                 "AU",
                 "AZ",
                 "BA",
                 "BB",
                 "BD",
                 "BE",
                 "BF",
                 "BG",
                 "BH",
                 "BI",
                 "BJ",
                 "BN",
                 "BO",
                 "BR",
                 "BS",
                 "BT",
                 "BW",
                 "BY",
                 "BZ",
                 "CA",
                 "CD",
                 "CG",
                 "CH",
                 "CI",
                 "CL",
                 "CM",
                 "CO",
                 "CR",
                 "CV",
                 "CW",
                 "CY",
                 "CZ",
                 "DE",
                 "DJ",
                 "DK",
                 "DM",
                 "DO",
                 "DZ",
                 "EC",
                 "EE",
                 "EG",
                 "ES",
                 "FI",
                 "FJ",
                 "FM",
                 "FR",
                 "GA",
                 "GB",
                 "GD",
                 "GE",
                 "GH",
                 "GM",
                 "GN",
                 "GQ",
                 "GR",
                 "GT",
                 "GW",
                 "GY",
                 "HK",
                 "HN",
                 "HR",
                 "HT",
                 "HU",
                 "ID",
                 "IE",
                 "IL",
                 "IN",
                 "IQ",
                 "IS",
                 "IT",
                 "JM",
                 "JO",
                 "JP",
                 "KE",
                 "KG",
                 "KH",
                 "KI",
                 "KM",
                 "KN",
                 "KR",
                 "KW",
                 "KZ",
                 "LA",
                 "LB",
                 "LC",
                 "LI",
                 "LK",
                 "LR",
                 "LS",
                 "LT",
                 "LU",
                 "LV",
                 "LY",
                 "MA",
                 "MC",
                 "MD",
                 "ME",
                 "MG",
                 "MH",
                 "MK",
                 "ML",
                 "MN",
                 "MO",
                 "MR",
                 "MT",
                 "MU",
                 "MV",
                 "MW",
                 "MX",
                 "MY",
                 "MZ",
                 "NA",
                 "NE",
                 "NG",
                 "NI",
                 "NL",
                 "NO",
                 "NP",
                 "NR",
                 "NZ",
                 "OM",
                 "PA",
                 "PE",
                 "PG",
                 "PH",
                 "PK",
                 "PL",
                 "PS",
                 "PT",
                 "PW",
                 "PY",
                 "QA",
                 "RO",
                 "RS",
                 "RW",
                 "SA",
                 "SB",
                 "SC",
                 "SE",
                 "SG",
                 "SI",
                 "SK",
                 "SL",
                 "SM",
                 "SN",
                 "SR",
                 "ST",
                 "SV",
                 "SZ",
                 "TD",
                 "TG",
                 "TH",
                 "TJ",
                 "TL",
                 "TN",
                 "TO",
                 "TR",
                 "TT",
                 "TV",
                 "TW",
                 "TZ",
                 "UA",
                 "UG",
                 "US",
                 "UY",
                 "UZ",
                 "VC",
                 "VE",
                 "VN",
                 "VU",
                 "WS",
                 "XK",
                 "ZA",
                 "ZM",
                 "ZW"
             ],
             "external_urls": {
                 "spotify": "https://open.spotify.com/album/5omNd3Mkij9C3ZeW19rRmv"
             },
             "href": "https://api.spotify.com/v1/albums/5omNd3Mkij9C3ZeW19rRmv",
             "id": "5omNd3Mkij9C3ZeW19rRmv",
             "images": [
                 {
                     "height": 640,
                     "url": "https://i.scdn.co/image/ab67616d0000b2738f072024e0358fc5c62eba41",
                     "width": 640
                 },
                 {
                     "height": 300,
                     "url": "https://i.scdn.co/image/ab67616d00001e028f072024e0358fc5c62eba41",
                     "width": 300
                 },
                 {
                     "height": 64,
                     "url": "https://i.scdn.co/image/ab67616d000048518f072024e0358fc5c62eba41",
                     "width": 64
                 }
             ],
             "name": "DESPECHÁ",
             "release_date": "2022-07-28",
             "release_date_precision": "day",
             "total_tracks": 1,
             "type": "album",
             "uri": "spotify:album:5omNd3Mkij9C3ZeW19rRmv"
         }
     ],
     "limit": 2,
     "next": "https://api.spotify.com/v1/browse/new-releases?offset=2&limit=2",
     "offset": 0,
     "previous": null,
     "total": 100
 }
}

 */
