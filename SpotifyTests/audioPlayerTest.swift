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
        let mockAudioTrack1 = AudioTrack(with: "https://p.scdn.co/mp3-preview/7a9f9a0239ec479cde3b8333647ae8ab06ed0abc?cid=56129e9c39744aa09f73de36f1e56c87")
        let mockAudioTrack2 = AudioTrack(with: "https://p.scdn.co/mp3-preview/ef21869a4f8ed426eaa02ecc4738137f70f27546?cid=56129e9c39744aa09f73de36f1e56c87")
        let mockAudioTrack3 = AudioTrack(with: "https://p.scdn.co/mp3-preview/578a48a4f3fa60d2bb7c9d3b6ff56cbbfb8e8acd?cid=56129e9c39744aa09f73de36f1e56c87")
        let mockTracks:[AudioTrack] = [mockAudioTrack1, mockAudioTrack2, mockAudioTrack3]
        sut = AudioPlayer(tracks: mockTracks)
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
        let exp = expectation(description: "Convert url avAsset to player item ")
        sut.convertAVAssetToPlayerItem(asset: mockAVURLAsset) { result in
            switch result {
            case .success(let playerItem):
                // Test here
                exp.fulfill()
                print("Success")
                
            case .failure(let error):
                print(error)
                XCTAssertNil(false)
            }
        }
        
        waitForExpectations(timeout: 3)
        
    }
    //loadTracksAndConvertToAvAseet
//    func test_load_tracks_and_convert_to_avAsset() {
//        let exp = expectation(description: "Convert url avAsset to player item ")
//        sut.loadTracksAndConverToPlayerItems(with: sut.tracks) { resut in
//            switch resut {
//            case .success(let playerItems):
//                exp.fulfill()
//                DispatchQueue.main.async {
//                XCTAssertEqual(playerItems.count, 3)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//        waitForExpectations(timeout: 10)
//    }

}

