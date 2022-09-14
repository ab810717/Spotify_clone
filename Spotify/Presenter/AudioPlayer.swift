//
//  AudioPlayer.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/22.
//

import Foundation
import AVFoundation
import UIKit
class AudioPlayer: NSObject {
    
    // MARK: - Properties
    public var audioPlayerConfig:Dictionary<String,Any> = [
        "loop": false,
        "volume": 5.0
    ]
    var tracks:[AudioTrack] = []
    var playerItems = [AVPlayerItem]() {
        didSet {
            if self.playerItems.count == 1 {
                self.setupObservers()
            }
            if self.playerItems.count == self.tracks.count {
                print("Completed, playerItems.count: \(playerItems.count)")
            }
        }
    }
    
    var playingItemindex = 0
    var numberOfTracks:Int = 0
    var isReady = false
    
    let group = DispatchGroup()
    var asset: AVURLAsset? {
        didSet {
            guard let newAsset = asset else { return }
            asynchronouslyLoadURLAsset(newAsset, appendDirectly: false)
        }
    }
    
    let assetKeysRequiredToPlay = ["playable"]
    let assetQueue = DispatchQueue(label: "randomQueue", qos: .utility)
    var queuePlayer: AVQueuePlayer?
    var playerVC: PlayerViewController?
    
    var audioQueueObserver: NSKeyValueObservation?
    var audioQueueStatusObserver: NSKeyValueObservation?
    
    // MARK: - Lifecycle
    deinit {
        /// Remove any KVO observer.
        print("DEINIT: Remove any KVO observer.")
        self.queuePlayer = nil
        self.audioQueueObserver?.invalidate()
        self.audioQueueStatusObserver?.invalidate()
    }
    
    // MARK: - Public functions
    
    func loadAVAsset(with tracks:[AudioTrack]) {
        self.tracks = tracks
        self.numberOfTracks = tracks.count
        self.group.enter()
        var counter = 0
        for track in tracks {
            if counter > 0 {
                self.assetQueue.async {
                    self.group.wait()
                    self.group.enter()
                    if let url = URL(string: track.previewURL ?? "https://p.scdn.co/mp3-preview/b8730e38f19e5f8dbd5ed0349af227d696958000?cid=56129e9c39744aa09f73de36f1e56c87") {
                        self.asset = AVURLAsset(url: url)
                    }
                }
            } else {
                self.assetQueue.async {
                    if let url = URL(string: track.previewURL ?? "") {
                        self.asset = AVURLAsset(url: url)
                    }
                }
            }
            counter += 1
        }
        
    }
    
    func changeVolume(_ value: Float) {
        self.queuePlayer?.volume = value
    }
    
    func playFoward() {
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
    
    // MARK: - Private functions
    private func playTrack() {
        if playerItems.count > 0 {
            print("Current playing index: \(playingItemindex)")
            self.queuePlayer?.removeAllItems()
            self.queuePlayer?.replaceCurrentItem(with: playerItems[playingItemindex])
            self.queuePlayer?.play()
        }
    }
    
    private func asynchronouslyLoadURLAsset(_ newAsset: AVURLAsset, appendDirectly:Bool = false) {
        /*
         The asset invokes its completion handler on an arbitrary queue.
         To avoid multiple threads using our internal state at the same time
         we'll elect to use the main thread at all times, let's dispatch
         our handler to the main queue.
         */
        newAsset.loadValuesAsynchronously(forKeys: assetKeysRequiredToPlay) {
            /*
             The asset invokes its completion handler on an arbitrary queue.
             To avoid multiple threads using our internal state at the same time
             we'll elect to use the main thread at all times, let's dispatch
             our handler to the main queue.
             */
            DispatchQueue.main.async {
                for key in self.assetKeysRequiredToPlay {
                    var error: NSError?
                    if newAsset.statusOfValue(forKey: key, error: &error) == .failed {
                        let stringFormat = NSLocalizedString("error.asset_key_%@_failed.description", comment: "Can't use this AVAsset because one of it's keys failed to load")
                        let message = String.localizedStringWithFormat(stringFormat, key)
                        self.handleErrorWithMessage(message, error: error)
                        return
                    }
                }
                
                // We can't play this asset.
                if !newAsset.isPlayable || newAsset.hasProtectedContent {
                    let message = NSLocalizedString("error.asset_not_playable.description", comment: "Can't use this AVAsset because it isn't playable or has protected content")
                    self.handleErrorWithMessage(message)
                    return
                }
                
                /*
                 We can play this asset. Create a new `AVPlayerItem` and make
                 it our player's current item.
                 */
                if appendDirectly == false {
                    print("DEBUG: append aseet to playerItems!")
                    self.playerItems.append(AVPlayerItem(asset: newAsset))
                }
                else {
                    print("trying to add: ", newAsset.url)
                    self.playerItems.append(AVPlayerItem(asset: newAsset))
                    if self.queuePlayer?.canInsert(AVPlayerItem(asset: newAsset), after: self.queuePlayer?.items().last) == true {
                        self.queuePlayer?.insert(AVPlayerItem(asset: newAsset), after: self.queuePlayer?.items().last)
                    }
                    
                }
                self.group.leave()
            }
        }
    }
    
    
    private func setupObservers() {
        print("setupObservers")
        self.queuePlayer = AVQueuePlayer(items: self.playerItems)
        self.queuePlayer?.usesExternalPlaybackWhileExternalScreenIsActive = true
        self.audioQueueObserver = self.queuePlayer?.observe(\.currentItem, options: [.new], changeHandler: {  [weak self] (player, _) in
            guard let self = self else { return }
            print("media item changed..., current Index: \(self.playingItemindex)")
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
