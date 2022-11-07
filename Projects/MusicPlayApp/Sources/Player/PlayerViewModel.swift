//
//  PlayerViewModel.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/05.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import Domain
import Combine
import Foundation
import MediaPlayer

class PlayerViewModel: ObservableObject {
    static let shared = PlayerViewModel()
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var currentTrack: Track?
    @Published var isPlayerViewExpand = false
    @Published var isPlaying = false
    private var currentSong: MPMediaItem? {
        didSet {
            if let currentSong = self.currentSong {
                currentTrack = Track(mediaItem: currentSong)
            } else {
                currentTrack = nil
            }
        }
    }
    var currentTime: CGFloat {
        musicPlayer.currentPlaybackTime
    }
    var currentDuration: Double? {
        musicPlayer.nowPlayingItem?.playbackDuration
    }
    
    init() {
        NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.currentSong = self.musicPlayer.nowPlayingItem
            }
            .store(in: &bag)
        NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange)
            .sink { [weak self] _ in
                guard let self = self else { return }
                switch self.musicPlayer.playbackState {
                case .paused, .interrupted, .stopped: self.isPlaying = false
                default: self.isPlaying = true
                }
            }
            .store(in: &bag)
    }
    
    func play(track: Track) {
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
    
    func changeShuffleMode() {
        let current = musicPlayer.shuffleMode
        musicPlayer.shuffleMode = current == .songs ? .off : .songs
        objectWillChange.send()
    }
    
    func changeRepeatMode() {
        let current = musicPlayer.repeatMode
        let nextNum = current.rawValue + 1
        let nextMode = MPMusicRepeatMode(rawValue: nextNum == 4 ? 1 : nextNum)
        musicPlayer.repeatMode = nextMode ?? .default
        objectWillChange.send()
    }

}
