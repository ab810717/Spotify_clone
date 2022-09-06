//
//  FeaturedPlayListsResponse.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/29.
//

import Foundation

struct FeaturedPlayListsResponse: Codable {
    let playlists: PlaylistResponse
}

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}



struct User: Codable {
    let displayName: String
    let externalUrls: [String: String]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case id
    }
}




/*
 {
     "message": "Editor's picks",
     "playlists": {
         "href": "https://api.spotify.com/v1/browse/featured-playlists?timestamp=2022-07-29T08%3A13%3A46&offset=0&limit=20",
         "items": [
             {
                 "collaborative": false,
                 "description": "The very best in new music from around the world. Cover: Beyoncé",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DWXJfnUiYjUKT"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWXJfnUiYjUKT",
                 "id": "37i9dQZF1DWXJfnUiYjUKT",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f000000033166e1dc0ec2f23d77fa1fcc",
                         "width": null
                     }
                 ],
                 "name": "New Music Friday",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1OTA2NzkxNSwwMDAwMDAwMDdmNzU3OWY0OTM2NDBiY2EwNjE4Yzc1ZTI4OTcwODg3",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWXJfnUiYjUKT/tracks",
                     "total": 96
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DWXJfnUiYjUKT"
             },
             {
                 "collaborative": false,
                 "description": "New music from Quavo & Takeoff, Rod Wave and Lil Uzi Vert.",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DX0XUsuxWHRQd"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX0XUsuxWHRQd",
                 "id": "37i9dQZF1DX0XUsuxWHRQd",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f000000039603d906d777ed43ac878e68",
                         "width": null
                     }
                 ],
                 "name": "RapCaviar",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1OTA2NzIwMCwwMDAwMDAwMDIxNzRjMTQ1ODlkODIzODk3ZjI5NjNlZTVjOGU1YmZj",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX0XUsuxWHRQd/tracks",
                     "total": 50
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DX0XUsuxWHRQd"
             },
             {
                 "collaborative": false,
                 "description": "The best feel-good songs of the 1980s.",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DWYAcBZSAVhlf"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWYAcBZSAVhlf",
                 "id": "37i9dQZF1DWYAcBZSAVhlf",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f000000035c9dc4f37e6f851171509ddd",
                         "width": null
                     }
                 ],
                 "name": "Happy 80s",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1NDE1MjExNywwMDAwMDAwMDFiZGQzZDMxYTEzZjM1MzBiNjAzMTVjMWU5ZTllOTZk",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWYAcBZSAVhlf/tracks",
                     "total": 100
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DWYAcBZSAVhlf"
             },
             {
                 "collaborative": false,
                 "description": "The biggest songs of the 1980s.",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DX4UtSsGT1Sbe"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX4UtSsGT1Sbe",
                 "id": "37i9dQZF1DX4UtSsGT1Sbe",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f000000034ce19ae6ab310b31c8b4f998",
                         "width": null
                     }
                 ],
                 "name": "All Out 80s",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1NjY4NzAwMSwwMDAwMDAwMGVlMmJhMGI5MTMwNmZhMWE1Zjc0OGY0N2IyYzI2MTJi",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX4UtSsGT1Sbe/tracks",
                     "total": 150
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DX4UtSsGT1Sbe"
             },
             {
                 "collaborative": false,
                 "description": "baby all i wanna do is coast cover: Hailee Steinfeld\n",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DXca8AyWK6Y7g"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXca8AyWK6Y7g",
                 "id": "37i9dQZF1DXca8AyWK6Y7g",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f00000003fad78fdfce5939efc338e2db",
                         "width": null
                     }
                 ],
                 "name": "young & free",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1OTA4MjQyNiwwMDAwMDAwMGQ0MWQ4Y2Q5OGYwMGIyMDRlOTgwMDk5OGVjZjg0Mjdl",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXca8AyWK6Y7g/tracks",
                     "total": 150
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DXca8AyWK6Y7g"
             },
             {
                 "collaborative": false,
                 "description": "Your daily dose of soul-infused music! Cover: Cory Henry",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DWSXWSaQmvWOB"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWSXWSaQmvWOB",
                 "id": "37i9dQZF1DWSXWSaQmvWOB",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f00000003128c9597d4f0d94b854b6873",
                         "width": null
                     }
                 ],
                 "name": "Soul 'n' the City",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1OTA4MjM3MCwwMDAwMDAwMGQ0MWQ4Y2Q5OGYwMGIyMDRlOTgwMDk5OGVjZjg0Mjdl",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWSXWSaQmvWOB/tracks",
                     "total": 100
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DWSXWSaQmvWOB"
             },
             {
                 "collaborative": false,
                 "description": "Beyoncé is on top of the Hottest 50!",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXcBWIGoYBM5M",
                 "id": "37i9dQZF1DXcBWIGoYBM5M",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f000000034f622613c93fcfc3066c4e9f",
                         "width": null
                     }
                 ],
                 "name": "Today's Top Hits",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1OTA2NzIwMCwwMDAwMDAwMGUyNzcwMWNjNzUyNzgwM2Q2OWU5OTM0NDg3ZGIxOTE4",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXcBWIGoYBM5M/tracks",
                     "total": 50
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"
             },
             {
                 "collaborative": false,
                 "description": "Hits to boost your mood and fill you with happiness!",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DXdPec7aLTmlC"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXdPec7aLTmlC",
                 "id": "37i9dQZF1DXdPec7aLTmlC",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f000000035af1070c80cd50dbbb4cfa19",
                         "width": null
                     }
                 ],
                 "name": "Happy Hits!",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1ODQ0MDkyMCwwMDAwMDAwMGM2ODBmYWExZGVhNmYyZGYzMWE4ODE0NzkxOTExNzBk",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXdPec7aLTmlC/tracks",
                     "total": 100
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DXdPec7aLTmlC"
             },
             {
                 "collaborative": false,
                 "description": "Get your day off to a cracking start!",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DXc5e2bJhV6pu"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXc5e2bJhV6pu",
                 "id": "37i9dQZF1DXc5e2bJhV6pu",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f00000003037da32de996d7c859b3b563",
                         "width": null
                     }
                 ],
                 "name": "Morning Motivation",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1OTAxNjgwMCwwMDAwMDAwMGM2YmI1MjhmNjgwOWZhZjM5Y2EwZTY4ZGI5NDIxNmNl",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXc5e2bJhV6pu/tracks",
                     "total": 80
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DXc5e2bJhV6pu"
             },
             {
                 "collaborative": false,
                 "description": "Keep it low-key with all of today's chill pop. Cover: Madeline The Person",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DX0MLFaUdXnjA"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX0MLFaUdXnjA",
                 "id": "37i9dQZF1DX0MLFaUdXnjA",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f000000039e50f7e93efe102902d00670",
                         "width": null
                     }
                 ],
                 "name": "Chill Pop",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTY1ODgwMzA5MCwwMDAwMDAwMGE0YmVmNTc2Mjk2N2FiMmE4MzA2NjU3M2I1NGU2NTA2",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX0MLFaUdXnjA/tracks",
                     "total": 97
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DX0MLFaUdXnjA"
             },
             {
                 "collaborative": false,
                 "description": "Uplifting anthems to power you through 'til the weekend.",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/playlist/37i9dQZF1DX1g0iEXLFycr"
                 },
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX1g0iEXLFycr",
                 "id": "37i9dQZF1DX1g0iEXLFycr",
                 "images": [
                     {
                         "height": null,
                         "url": "https://i.scdn.co/image/ab67706f00000003104f039c1cc982d3617f4e4b",
                         "width": null
                     }
                 ],
                 "name": "Feel Good Friday",
                 "owner": {
                     "display_name": "Spotify",
                     "external_urls": {
                         "spotify": "https://open.spotify.com/user/spotify"
                     },
                     "href": "https://api.spotify.com/v1/users/spotify",
                     "id": "spotify",
                     "type": "user",
                     "uri": "spotify:user:spotify"
                 },
                 "primary_color": null,
                 "public": null,
                 "snapshot_id": "MTU5ODU0NDYyNSwwMDAwMDAwMDNhYjFhMzM3NzdjMTI5MzgyMGRjODQzMjVjMGFhM2U1",
                 "tracks": {
                     "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX1g0iEXLFycr/tracks",
                     "total": 100
                 },
                 "type": "playlist",
                 "uri": "spotify:playlist:37i9dQZF1DX1g0iEXLFycr"
             }
         ],
         "limit": 20,
         "next": null,
         "offset": 0,
         "previous": null,
         "total": 11
     }
 }{
 "message": "Editor's picks",
 "playlists": {
     "href": "https://api.spotify.com/v1/browse/featured-playlists?timestamp=2022-07-29T08%3A13%3A46&offset=0&limit=20",
     "items": [
         {
             "collaborative": false,
             "description": "The very best in new music from around the world. Cover: Beyoncé",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DWXJfnUiYjUKT"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWXJfnUiYjUKT",
             "id": "37i9dQZF1DWXJfnUiYjUKT",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f000000033166e1dc0ec2f23d77fa1fcc",
                     "width": null
                 }
             ],
             "name": "New Music Friday",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1OTA2NzkxNSwwMDAwMDAwMDdmNzU3OWY0OTM2NDBiY2EwNjE4Yzc1ZTI4OTcwODg3",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWXJfnUiYjUKT/tracks",
                 "total": 96
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DWXJfnUiYjUKT"
         },
         {
             "collaborative": false,
             "description": "New music from Quavo & Takeoff, Rod Wave and Lil Uzi Vert.",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DX0XUsuxWHRQd"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX0XUsuxWHRQd",
             "id": "37i9dQZF1DX0XUsuxWHRQd",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f000000039603d906d777ed43ac878e68",
                     "width": null
                 }
             ],
             "name": "RapCaviar",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1OTA2NzIwMCwwMDAwMDAwMDIxNzRjMTQ1ODlkODIzODk3ZjI5NjNlZTVjOGU1YmZj",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX0XUsuxWHRQd/tracks",
                 "total": 50
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DX0XUsuxWHRQd"
         },
         {
             "collaborative": false,
             "description": "The best feel-good songs of the 1980s.",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DWYAcBZSAVhlf"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWYAcBZSAVhlf",
             "id": "37i9dQZF1DWYAcBZSAVhlf",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f000000035c9dc4f37e6f851171509ddd",
                     "width": null
                 }
             ],
             "name": "Happy 80s",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1NDE1MjExNywwMDAwMDAwMDFiZGQzZDMxYTEzZjM1MzBiNjAzMTVjMWU5ZTllOTZk",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWYAcBZSAVhlf/tracks",
                 "total": 100
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DWYAcBZSAVhlf"
         },
         {
             "collaborative": false,
             "description": "The biggest songs of the 1980s.",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DX4UtSsGT1Sbe"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX4UtSsGT1Sbe",
             "id": "37i9dQZF1DX4UtSsGT1Sbe",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f000000034ce19ae6ab310b31c8b4f998",
                     "width": null
                 }
             ],
             "name": "All Out 80s",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1NjY4NzAwMSwwMDAwMDAwMGVlMmJhMGI5MTMwNmZhMWE1Zjc0OGY0N2IyYzI2MTJi",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX4UtSsGT1Sbe/tracks",
                 "total": 150
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DX4UtSsGT1Sbe"
         },
         {
             "collaborative": false,
             "description": "baby all i wanna do is coast cover: Hailee Steinfeld\n",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DXca8AyWK6Y7g"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXca8AyWK6Y7g",
             "id": "37i9dQZF1DXca8AyWK6Y7g",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f00000003fad78fdfce5939efc338e2db",
                     "width": null
                 }
             ],
             "name": "young & free",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1OTA4MjQyNiwwMDAwMDAwMGQ0MWQ4Y2Q5OGYwMGIyMDRlOTgwMDk5OGVjZjg0Mjdl",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXca8AyWK6Y7g/tracks",
                 "total": 150
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DXca8AyWK6Y7g"
         },
         {
             "collaborative": false,
             "description": "Your daily dose of soul-infused music! Cover: Cory Henry",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DWSXWSaQmvWOB"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWSXWSaQmvWOB",
             "id": "37i9dQZF1DWSXWSaQmvWOB",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f00000003128c9597d4f0d94b854b6873",
                     "width": null
                 }
             ],
             "name": "Soul 'n' the City",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1OTA4MjM3MCwwMDAwMDAwMGQ0MWQ4Y2Q5OGYwMGIyMDRlOTgwMDk5OGVjZjg0Mjdl",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DWSXWSaQmvWOB/tracks",
                 "total": 100
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DWSXWSaQmvWOB"
         },
         {
             "collaborative": false,
             "description": "Beyoncé is on top of the Hottest 50!",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXcBWIGoYBM5M",
             "id": "37i9dQZF1DXcBWIGoYBM5M",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f000000034f622613c93fcfc3066c4e9f",
                     "width": null
                 }
             ],
             "name": "Today's Top Hits",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1OTA2NzIwMCwwMDAwMDAwMGUyNzcwMWNjNzUyNzgwM2Q2OWU5OTM0NDg3ZGIxOTE4",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXcBWIGoYBM5M/tracks",
                 "total": 50
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"
         },
         {
             "collaborative": false,
             "description": "Hits to boost your mood and fill you with happiness!",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DXdPec7aLTmlC"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXdPec7aLTmlC",
             "id": "37i9dQZF1DXdPec7aLTmlC",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f000000035af1070c80cd50dbbb4cfa19",
                     "width": null
                 }
             ],
             "name": "Happy Hits!",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1ODQ0MDkyMCwwMDAwMDAwMGM2ODBmYWExZGVhNmYyZGYzMWE4ODE0NzkxOTExNzBk",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXdPec7aLTmlC/tracks",
                 "total": 100
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DXdPec7aLTmlC"
         },
         {
             "collaborative": false,
             "description": "Get your day off to a cracking start!",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DXc5e2bJhV6pu"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXc5e2bJhV6pu",
             "id": "37i9dQZF1DXc5e2bJhV6pu",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f00000003037da32de996d7c859b3b563",
                     "width": null
                 }
             ],
             "name": "Morning Motivation",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1OTAxNjgwMCwwMDAwMDAwMGM2YmI1MjhmNjgwOWZhZjM5Y2EwZTY4ZGI5NDIxNmNl",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DXc5e2bJhV6pu/tracks",
                 "total": 80
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DXc5e2bJhV6pu"
         },
         {
             "collaborative": false,
             "description": "Keep it low-key with all of today's chill pop. Cover: Madeline The Person",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DX0MLFaUdXnjA"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX0MLFaUdXnjA",
             "id": "37i9dQZF1DX0MLFaUdXnjA",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f000000039e50f7e93efe102902d00670",
                     "width": null
                 }
             ],
             "name": "Chill Pop",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTY1ODgwMzA5MCwwMDAwMDAwMGE0YmVmNTc2Mjk2N2FiMmE4MzA2NjU3M2I1NGU2NTA2",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX0MLFaUdXnjA/tracks",
                 "total": 97
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DX0MLFaUdXnjA"
         },
         {
             "collaborative": false,
             "description": "Uplifting anthems to power you through 'til the weekend.",
             "external_urls": {
                 "spotify": "https://open.spotify.com/playlist/37i9dQZF1DX1g0iEXLFycr"
             },
             "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX1g0iEXLFycr",
             "id": "37i9dQZF1DX1g0iEXLFycr",
             "images": [
                 {
                     "height": null,
                     "url": "https://i.scdn.co/image/ab67706f00000003104f039c1cc982d3617f4e4b",
                     "width": null
                 }
             ],
             "name": "Feel Good Friday",
             "owner": {
                 "display_name": "Spotify",
                 "external_urls": {
                     "spotify": "https://open.spotify.com/user/spotify"
                 },
                 "href": "https://api.spotify.com/v1/users/spotify",
                 "id": "spotify",
                 "type": "user",
                 "uri": "spotify:user:spotify"
             },
             "primary_color": null,
             "public": null,
             "snapshot_id": "MTU5ODU0NDYyNSwwMDAwMDAwMDNhYjFhMzM3NzdjMTI5MzgyMGRjODQzMjVjMGFhM2U1",
             "tracks": {
                 "href": "https://api.spotify.com/v1/playlists/37i9dQZF1DX1g0iEXLFycr/tracks",
                 "total": 100
             },
             "type": "playlist",
             "uri": "spotify:playlist:37i9dQZF1DX1g0iEXLFycr"
         }
     ],
     "limit": 20,
     "next": null,
     "offset": 0,
     "previous": null,
     "total": 11
 }
}
 */
