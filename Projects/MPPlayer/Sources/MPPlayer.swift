//
//  MPPlayer.swift
//  DataApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.data. All rights reserved.
//

import Combine
import Domain
import MediaPlayer

public class MPPlayer: MusicPlayRepository {
    public var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    public init() { }
    
    public var currentPlaybackTime: TimeInterval {
        musicPlayer.currentPlaybackTime
    }
    
    public var playbackDuration: TimeInterval? {
        musicPlayer.nowPlayingItem?.playbackDuration
    }
    
    public var playbackState: MusicPlaybackState {
        switch musicPlayer.playbackState {
        case .stopped: return .stopped
        case .interrupted: return .interrupted
        case .playing: return .playing
        default: return .paused
        }
    }
    
    public var shuffleMode: MusicShuffleMode {
        switch musicPlayer.shuffleMode {
        case .songs: return .songs
        case .albums: return .albums
        default: return .off
        }
    }
    
    public var repeatMode: MusicRepeatMode {
        switch musicPlayer.repeatMode {
        case .one: return .one
        case .all: return .all
        default: return .none
        }
    }
    
    public func play() {
        musicPlayer.play()
    }
    
    public func pause() {
        musicPlayer.pause()
    }
    
    public func play(track: Track) {
        DispatchQueue.global().async {
            let query = MPMediaQuery.songs()
            let predicate = MPMediaPropertyPredicate(value: "\(track.id)", forProperty: MPMediaItemPropertyPersistentID)
            query.addFilterPredicate(predicate)
            
            guard let song = query.items?.first else { return }
            let albumQuery = MPMediaQuery.albums()
            let albumPredicate = MPMediaPropertyPredicate(value: NSNumber(value: song.albumPersistentID), forProperty: MPMediaItemPropertyAlbumPersistentID)
            albumQuery.addFilterPredicate(albumPredicate)
            
            DispatchQueue.main.async {
                if let album = albumQuery.collections?.first,
                    let index = album.items.firstIndex(where: { "\($0.persistentID)" == track.id}){
                    self.musicPlayer.setQueue(with: album)
                    self.musicPlayer.nowPlayingItem = album.items[index]
                    self.musicPlayer.play()
                } else {
                    self.musicPlayer.setQueue(with: MPMediaItemCollection(items: [song]))
                    self.musicPlayer.play()
                }
            }
        }
    }
    
    public func skipToNextItem() {
        musicPlayer.skipToNextItem()
    }
    
    public func skipToPreviousItem() {
        musicPlayer.skipToPreviousItem()
    }
    
    public func changeShuffleMode(isOnForce: Bool) {
        if isOnForce {
            musicPlayer.shuffleMode = .songs
            return
        }
        let current = musicPlayer.shuffleMode
        musicPlayer.shuffleMode = current == .songs ? .off : .songs
    }
    
    public func changeRepeatMode() {
        let current = musicPlayer.repeatMode
        let nextNum = current.rawValue + 1
        let nextMode = MPMusicRepeatMode(rawValue: nextNum == 4 ? 1 : nextNum)
        musicPlayer.repeatMode = nextMode ?? .default
    }
    
    public func didChangeCurrentTrackPlayingItem() -> AnyPublisher<Track?, Never> {
        return NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
            .map { [weak self] _ in
                if let nowPlaying = self?.musicPlayer.nowPlayingItem {
                    return Track(mediaItem: nowPlaying)
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func didChangePlaybackState() -> AnyPublisher<MusicPlaybackState, Never> {
        return NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange)
            .map { [weak self] _ in
                let state: MusicPlaybackState
                
                switch self?.musicPlayer.playbackState {
                case .stopped: state = .stopped
                case .interrupted: state = .interrupted
                case .playing: state = .playing
                default: state = .paused
                }
                
                return state
            }
            .eraseToAnyPublisher()
    }
}
