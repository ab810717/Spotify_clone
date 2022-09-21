//
//  AudioPlayer.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/22.
//

import Foundation
import AVFoundation
import UIKit

enum LoadAssertError: Error {
    case failedToLoad
    case cancelled
    case unknown
}

class AudioPlayer: NSObject {
    
    // MARK: - Properties
    public var audioPlayerConfig:Dictionary<String,Any> = [
        "loop": false,
        "volume": 5.0
    ]
    
    var tracks:[AudioTrack] = []
    var avPlayerItemPool = [AVPlayerItem]() {
        didSet {
            if self.avPlayerItemPool.count == 1 {
                print("first player item has been added to avPlayerItemPool!")
                self.setupObservers()
            }
            if self.avPlayerItemPool.count == self.tracks.count {
                isReadyToPlayAllTracks = true
                print("Completed, playerItems.count: \(avPlayerItemPool.count)")
            }
        }
    }
    
    var playingItemindex = 0
    var numberOfTracks:Int = 0
    var isReadyToPlayAllTracks = false
    let group = DispatchGroup()
    var urlAsset: AVURLAsset? {
        didSet {
            guard urlAsset != nil else { return }
            print("urlAsset has been set!")
        }
    }
    let assetKeysRequiredToPlay = ["playable"]
    let assetQueue = DispatchQueue(label: "randomQueue", qos: .utility)
    var queuePlayer: AVQueuePlayer?
    var playerVC: PlayerViewController?
    var audioQueueObserver: NSKeyValueObservation?
    // MARK: - Lifecycle
    
    init(tracks:[AudioTrack]) {
        self.tracks = tracks
        self.numberOfTracks = tracks.count
    }
    
    deinit {
        /// Remove any KVO observer.
        print("DEINIT: Remove any KVO observer.")
        self.queuePlayer = nil
        self.audioQueueObserver?.invalidate()
    }
    
    // MARK: - Public functions
    func loadTracksAndConverToPlayerItems(with tracks:[AudioTrack], completion:@escaping(Result<[PlaylistItem], Error>) -> Void) {
        self.tracks = tracks
        
        for track in tracks {
            if let url = URL(string: track.previewURL ?? "https://p.scdn.co/mp3-preview/b8730e38f19e5f8dbd5ed0349af227d696958000?cid=56129e9c39744aa09f73de36f1e56c87") {
                self.assetQueue.async {
                    self.urlAsset = AVURLAsset(url: url)
                    self.group.enter()
                    self.convertAVAssetToPlayerItem(asset: self.urlAsset!) {[weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let avPlayerItem):
                            print("Get avPlayerItem: \(avPlayerItem.description)")
                            DispatchQueue.main.async {
                                print("Append to avPlayerIem")
                                self.avPlayerItemPool.append(avPlayerItem)
                                self.group.leave()
                            }
                        case .failure(let error):
                            print("DEBUGT: Get an error: \(error)")
                        }
                    }
                    self.group.wait()
                }
            }
        }
        
    }
    
    func convertAVAssetToPlayerItem(asset: AVURLAsset, compltion: @escaping (Result<AVPlayerItem, Error>) -> Void) {
        asset.loadValuesAsynchronously(forKeys: self.assetKeysRequiredToPlay) {
            var error:NSError? = nil
            switch asset.statusOfValue(forKey: self.assetKeysRequiredToPlay[0], error: &error) {
            case .unknown:
                compltion(.failure(LoadAssertError.unknown))
            case .loading:
                print("loading")
            case .loaded:
                // convert it to AVPlayerItem
                print("DEBUG: Loaded!")
                let avPlayerItem = AVPlayerItem(asset: asset)
                compltion(.success(avPlayerItem))
            case .failed:
                print("failed, need to handle error here!")
                compltion(.failure(LoadAssertError.failedToLoad))
            case .cancelled:
                compltion(.failure(LoadAssertError.cancelled))
            @unknown default:
                print("unknown")
            }
        }
    }
    
    func changeVolume(_ value: Float) {
        self.queuePlayer?.volume = value
    }
    
    func playFoward() {
        guard playingItemindex < self.numberOfTracks else {
            print("DEBUG: INVALID Operation: playingItemindex: \(playingItemindex) / \(numberOfTracks)")
            return
        }
        if playingItemindex == numberOfTracks - 1 {
            playingItemindex = numberOfTracks - 1
        } else {
            playingItemindex += 1
        }
        playTrack()
    }
    
    func playBackword() {
        if playingItemindex == 0 {
            playingItemindex = 0
        } else {
            playingItemindex -= 1
        }
        playTrack()
    }
    
    func playAlltracks() {
        self.queuePlayer = AVQueuePlayer(items: self.avPlayerItemPool)
        self.queuePlayer?.play()
    }
    
    // MARK: - Private functions
    private func playTrack() {
        guard playingItemindex < avPlayerItemPool.count else { return }
        if avPlayerItemPool.count > 0 {
            print("Current playing index: \(playingItemindex)")
            self.queuePlayer?.removeAllItems()
            self.queuePlayer?.replaceCurrentItem(with: avPlayerItemPool[playingItemindex])
            self.queuePlayer?.play()
        }
    }
    
    
    
    private func setupObservers() {
        print("setupObservers")
        self.queuePlayer = AVQueuePlayer(items: self.avPlayerItemPool)
        self.queuePlayer?.usesExternalPlaybackWhileExternalScreenIsActive = true
        self.audioQueueObserver = self.queuePlayer?.observe(\.currentItem, options: [.new], changeHandler: {  [weak self] (player, _) in
            guard let self = self else { return }
            print("media item changed..., current Index: playing item index: \(self.playingItemindex)")
            
        })
        self.queuePlayer?.play()
    }
    
    // MARK: - Error Handling
    
    func handleErrorWithMessage(_ message: String?, error: Error? = nil) {
        NSLog("Error occured with message: \(String(describing: message)), error: \(String(describing: error)).")
        
        let alertTitle = NSLocalizedString("alert.error.title", comment: "Alert title for errors")
        let defaultAlertMessage = NSLocalizedString("error.default.description", comment: "Default error message when no NSError provided")
        
        let alert = UIAlertController(title: alertTitle, message: message == nil ? defaultAlertMessage : message, preferredStyle: UIAlertController.Style.alert)
        
        let alertActionTitle = NSLocalizedString("alert.error.actions.OK", comment: "OK on error alert")
        
        let alertAction = UIAlertAction(title: alertActionTitle, style: .default, handler: nil)
        
        alert.addAction(alertAction)
    }
}
