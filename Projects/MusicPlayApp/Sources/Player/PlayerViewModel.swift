//
//  PlayerViewModel.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/05.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import Combine
import Domain
import MpPlayer
import Foundation
import UIKit

class PlayerViewModel: ObservableObject {
    private let playUseCase: MusicPlayUseCase
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var currentTrack: Track?
    @Published var isPlayerViewExpand = false
    @Published var isPlaying = false
    var currentTime: CGFloat {
        CGFloat(playUseCase.currentPlaybackTime)
    }
    var currentDuration: Double? {
        playUseCase.playbackDuration
    }
    var playbackState: MusicPlaybackState {
        playUseCase.playbackState
    }
    var shuffleMode: MusicShuffleMode {
        playUseCase.shuffleMode
    }
    var repeatMode: MusicRepeatMode {
        playUseCase.repeatMode
    }
    
    init(playUseCase: MusicPlayUseCase) {
        self.playUseCase = playUseCase
        playUseCase.didChangeCurrentTrackPlayingItem()
            .sink { [weak self] track in
                guard let self = self else { return }
                self.currentTrack = track
            }
            .store(in: &bag)
        
        playUseCase.didChangePlaybackState()
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .stopped, .paused, .interrupted: self.isPlaying = false
                default: self.isPlaying = true
                }
            }
            .store(in: &bag)
    }
    
    func play() {
        playUseCase.play()
    }
    
    func pause() {
        playUseCase.pause()
    }
    
    func play(track: Track) {
        playUseCase.play(track: track)
    }
    
    func skipToNextItem() {
        playUseCase.skipToNextItem()
    }
    
    func skipToPreviousItem() {
        playUseCase.skipToPreviousItem()
    }
    
    func changeShuffleMode(isOnForce: Bool = false) {
        playUseCase.changeShuffleMode(isOnForce: isOnForce)
        objectWillChange.send()
    }
    
    func changeRepeatMode() {
        playUseCase.changeRepeatMode()
        objectWillChange.send()
    }

}
