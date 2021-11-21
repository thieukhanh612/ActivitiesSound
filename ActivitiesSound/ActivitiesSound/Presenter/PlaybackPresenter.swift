//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Дмитрий Старков on 03.05.2021.
//

import AVFoundation
import UIKit
import SwiftUI

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subTitle: String? { get }
    var imageURL: URL? { get }
}
protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackwards()
    func didSlideSlider(_ value: Float)
}
final class PlaybackPresenter{
    static let shared = PlaybackPresenter()
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    var currentTrack: AudioTrack? {
        if let track = track,tracks.isEmpty {
            return track
        } else if let player = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }
        return nil
    }
    
    func startPlayback(
        track: AudioTrack) {
            player?.replaceCurrentItem(with: nil)
            guard let url = URL(string: track.preview_url ?? "") else { return }
            player = AVPlayer(url: url)
            player?.volume = 0.5
            self.track = track
            self.tracks = []
            self.player?.play()
            
        }
    
    func startsPlayback(
        tracks: [AudioTrack]) {
            self.index = 0
            playerQueue?.removeAllItems()
            self.tracks = tracks
            self.track = nil
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
                guard let url = URL(string: $0.preview_url ?? "") else { return nil}
                return AVPlayerItem(url: url)
            }))
            self.playerQueue?.volume = 0.5
            self.playerQueue?.play()
        }
    @objc func playerDidFinishPlaying(note: NSNotification){
        index += 1
        
    }
    
    
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused { player.play() }
        } else if  let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            //not playlist or album
            player?.pause()
            player?.play()
        } else if index >= tracks.count - 1{
        }else if let player = playerQueue {
            player.advanceToNextItem()
         
            index += 1
        }
    }
    
    func didTapBackwards() {
        if tracks.isEmpty {
            //not playlist or album
            player?.pause()
            player?.play()
        } else if index - 1 < 0 {
//            playerQueue?.pause()
//            playerQueue?.removeAllItems()
//            playerQueue = AVQueuePlayer(items: [firstItem])
//            playerQueue?.play()
//            playerQueue?.volume = 0.5
            index = 0
        }else {
            index -= 1
            let previous = AVPlayerItem.init(url: URL(string: tracks[index].preview_url ?? "")!)
            let current = playerQueue?.currentItem
            playerQueue?.insert(previous , after: playerQueue?.currentItem)
            playerQueue?.advanceToNextItem()
            playerQueue?.insert(current ?? AVPlayerItem.init(url: URL(string: "")!), after: playerQueue?.currentItem)
            playerQueue?.play()
            playerQueue?.volume = 0.5
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
        playerQueue?.volume = value
    }
    
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subTitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    
}
