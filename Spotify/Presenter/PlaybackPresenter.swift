//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/15.
//

import Foundation
import UIKit
import AVFoundation

protocol PlaybackPresenterDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter{
    // MARK: - Properties
    static let shared = PlaybackPresenter()
    private var audioPlayer:AudioPlayer?
    
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var playingItemindex = 0
    var numberOfTracks:Int = 0
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if !tracks.isEmpty{
            return tracks[playingItemindex]
        }
        return nil
    }
    
    var player: AVPlayer?
//    var queuePlayer: AVQueuePlayer?
    var playerVC: PlayerViewController?
    private init () {}
    
    // MARK: - Play track and tracks functions
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        guard let url = URL(string: track.previewURL ?? "https://p.scdn.co/mp3-preview/b8730e38f19e5f8dbd5ed0349af227d696958000?cid=56129e9c39744aa09f73de36f1e56c87") else { return }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.datasource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) {
            [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        playingItemindex = 0
        self.audioPlayer = AudioPlayer()
        self.tracks = []
        self.tracks = tracks
        self.numberOfTracks = tracks.count
        print("DEBUG: Get tracks.count: \(tracks.count)")
        self.track = nil
        loadAsset(with: tracks)
        
        let vc = PlayerViewController()
        vc.datasource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }
    
    // MARK: - Private fucntions
    
    private func loadAsset(with tracks:[AudioTrack]) {
        guard let audioPlayer = audioPlayer else {
            return
        }
        audioPlayer.initialize(with: tracks)
    }
}

// MARK: - PlaybackPresenterDataSource
extension PlaybackPresenter: PlaybackPresenterDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}

// MARK: - PlayerViewControllerDelegate
extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didTapClose() {
        // reset state here!
        self.audioPlayer = nil
        self.player = nil
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
        self.audioPlayer?.changeVolume(value)
        
    }
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        } else if let player = audioPlayer?.queuePlayer {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapFoward() {
        if tracks.isEmpty {
            player?.pause()
        } else if let player = audioPlayer {
            if playingItemindex == numberOfTracks - 1 {
                playingItemindex = numberOfTracks - 1
            } else {
                playingItemindex += 1
            }
            print("Get track info \(playingItemindex) / \(numberOfTracks)")
            player.playFoward()
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackward() {
        print("Did tapped backward!")
        if let player = player, tracks.isEmpty {
            player.pause()
            player.play()
        } else if let player = audioPlayer {
            if playingItemindex == 0 {
                playingItemindex = 0
            } else {
                playingItemindex -= 1
            }
            player.playBackword()
            playerVC?.refreshUI()
        }
    }
    
    
}


