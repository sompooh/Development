//
//  MusicPlayUseCase.swift
//  DomainApp
//
//  Created by USER on 2022/11/08.
//  Copyright © 2022 com.som.tuist.domain. All rights reserved.
//

import Combine
import Foundation

public protocol MusicPlayUseCase {
    var currentPlaybackTime: TimeInterval { get }
    var playbackDuration: TimeInterval? { get }
    var playbackState: MusicPlaybackState { get }
    var shuffleMode: MusicShuffleMode { get }
    var repeatMode: MusicRepeatMode { get }
    
    func play()
    func pause()
    func play(track: Track)
    func skipToNextItem()
    func skipToPreviousItem()
    func changeRepeatMode()
    func changeShuffleMode(isOnForce: Bool)
    func didChangeCurrentTrackPlayingItem() -> AnyPublisher<Track?, Never>
    func didChangePlaybackState() -> AnyPublisher<MusicPlaybackState, Never>
}

