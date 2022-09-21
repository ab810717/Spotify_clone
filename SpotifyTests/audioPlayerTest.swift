//
//  audioPlayerTest.swift
//  SpotifyTests
//
//  Created by Andy Hao on 2022/9/21.
//

import XCTest
import AVFoundation
@testable import Spotify
class audioPlayerTest: XCTestCase {
    var sut:AudioPlayer!
    override func setUp() {
        super.setUp()
        let mockAudioTrack1 = AudioTrack(with: "https://p.scdn.co/mp3-preview/fe4c5c156e9e4c9f8be2a50678e397e3963f616d?cid=56129e9c39744aa09f73de36f1e56c87")
        let mockAudioTrack2 = AudioTrack(with: "https://p.scdn.co/mp3-preview/fe4c5c156e9e4c9f8be2a50678e397e3963f616d?cid=56129e9c39744aa09f73de36f1e56c87")
        let mockAudioTrack3 = AudioTrack(with: "https://p.scdn.co/mp3-preview/4b4b905e2a74793a300a9932738ab4f653d9735e?cid=56129e9c39744aa09f73de36f1e56c87")
        let mockTracks:[AudioTrack] = [mockAudioTrack1, mockAudioTrack2, mockAudioTrack3]
        sut = AudioPlayer(tracks: mockTracks)
        sut.isTestEnv = true
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_initial_audio_player() {
        XCTAssertEqual(sut.tracks.count, 3)
    }
    
    func test_convert_a_avURLAsset_to_player_item() {
        let mockAVURLAsset = AVURLAsset(url: URL(string: "https://p.scdn.co/mp3-preview/7a9f9a0239ec479cde3b8333647ae8ab06ed0abc?cid=56129e9c39744aa09f73de36f1e56c87")!)
        let exp = expectation(description: #function)
        sut.convertAVAssetToPlayerItem(asset: mockAVURLAsset) { result in
            switch result {
            case .success(let playerItem):
                exp.fulfill()
                XCTAssertNotNil(playerItem)
            case .failure(let error):
                XCTFail("Expeceted get playerItem but faield \(error)")
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_load_tracks_and_convert_to_avplayer_items() {
        let exp = expectation(description: #function)
        sut.loadTracksAndConverToPlayerItems(with: sut.tracks) { result in
            switch result {
            case .success(let playerItems):
                exp.fulfill()
                XCTAssertEqual(playerItems.count, 3)
            case .failure(let error):
                XCTFail("Expeceted get playerItems but faield \(error)")
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func test_if_order_is_correct_in_playerItems() {
        let exp = expectation(description: #function)
        let expURLResult:[URL] = [
            URL(string: "https://p.scdn.co/mp3-preview/fe4c5c156e9e4c9f8be2a50678e397e3963f616d?cid=56129e9c39744aa09f73de36f1e56c87")!,
            URL(string: "https://p.scdn.co/mp3-preview/fe4c5c156e9e4c9f8be2a50678e397e3963f616d?cid=56129e9c39744aa09f73de36f1e56c87")!,
            URL(string: "https://p.scdn.co/mp3-preview/4b4b905e2a74793a300a9932738ab4f653d9735e?cid=56129e9c39744aa09f73de36f1e56c87")!
        ]
        sut.loadTracksAndConverToPlayerItems(with: sut.tracks) { result in
            switch result {
            case .success(let playerItems):
                var urls:[URL] = []
                for i in 0..<playerItems.count {
                    let url = (playerItems[i].asset as? AVURLAsset)?.url
                    urls.append(url!)
                }
                XCTAssertEqual(expURLResult, urls)
                exp.fulfill()
                
            case .failure(let error):
                XCTFail("Expeceted get playerItems but faield \(error)")
            }
        }
        waitForExpectations(timeout: 10)
    }
 
}

