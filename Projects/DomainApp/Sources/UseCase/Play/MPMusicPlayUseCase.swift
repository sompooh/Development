//
//  MPMusicPlayUseCase.swift
//  DomainApp
//
//  Created by USER on 2022/11/09.
//  Copyright © 2022 com.som.tuist.domain. All rights reserved.
//

import Foundation
import Combine

public final class MPMusicPlayUseCase: MusicPlayUseCase {
    
    public var currentPlaybackTime: TimeInterval {
        repository.currentPlaybackTime
    }
    public var playbackDuration: TimeInterval? {
        repository.playbackDuration
    }
    public var playbackState: MusicPlaybackState {
        repository.playbackState
    }
    public var shuffleMode: MusicShuffleMode {
        repository.shuffleMode
    }
    public var repeatMode: MusicRepeatMode {
        repository.repeatMode
    }
    
    let repository: MusicPlayRepository
    
    public init(repository: MusicPlayRepository) {
        self.repository = repository
    }
    
    public func play() {
        repository.play()
    }
    
    public func pause() {
        repository.pause()
    }
    
    public func play(track: Track) {
        repository.play(track: track)
    }
    
    public func skipToNextItem() {
        repository.skipToNextItem()
    }
    
    public func skipToPreviousItem() {
        repository.skipToPreviousItem()
    }
    
    public func changeRepeatMode() {
        repository.changeRepeatMode()
    }
    
    public func changeShuffleMode(isOnForce: Bool) {
        repository.changeShuffleMode(isOnForce: isOnForce)
    }
    
    public func didChangeCurrentTrackPlayingItem() -> AnyPublisher<Track?, Never> {
        return repository.didChangeCurrentTrackPlayingItem()
    }
    
    public func didChangePlaybackState() -> AnyPublisher<MusicPlaybackState, Never> {
        return repository.didChangePlaybackState()
    }
}
