//
//  PlayerViewModel.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/05.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import Foundation
import MediaPlayer
import Combine

class PlayerViewModel: ObservableObject {
    static let shared = PlayerViewModel()
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var currentSong: MPMediaItem?
    @Published var isPlayerViewExpand = false
    @Published var isPlaying = false
    @Published var volume: CGFloat = 0
    var currentTime: CGFloat {
        musicPlayer.currentPlaybackTime
    }
    var currentDuration: Double? {
        musicPlayer.nowPlayingItem?.playbackDuration
    }
    
    @Published var albums = [MPMediaItemCollection]()
    @Published var tracks = [MPMediaItem]()
    
    init() {
        NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.currentSong = self.musicPlayer.nowPlayingItem
            }
            .store(in: &cancellable)
        
        NotificationCenter.default.publisher(for: NSNotification.Name.MPMusicPlayerControllerVolumeDidChange)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.volume = CGFloat(AVAudioSession.sharedInstance().outputVolume)
            }
            .store(in: &cancellable)
    }
    
    func fetchSongs() {
        let songsQuery = MPMediaQuery.songs()
        if let songs = songsQuery.items {
            let sortType = NSSortDescriptor(key: MPMediaItemPropertyTitle, ascending: true)
            if let sortedSongs = NSArray(array: songs).sortedArray(using: [sortType]) as? [MPMediaItem] {
                tracks = sortedSongs
            }
        }
        
        let albumsQuery = MPMediaQuery.albums()
        if let albums = albumsQuery.collections {
            self.albums = albums
        }
    }

}
