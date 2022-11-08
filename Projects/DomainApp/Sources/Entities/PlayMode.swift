//
//  PlayMode.swift
//  DomainApp
//
//  Created by 김유미 on 2022/11/09.
//  Copyright © 2022 com.som.tuist.domain. All rights reserved.
//

import Foundation
public enum MusicRepeatMode : Int {
    case none = 1
    case one = 2
    case all = 3
}

public enum MusicShuffleMode : Int{
    case off = 1
    case songs = 2
    case albums = 3
}

public enum MusicPlaybackState : Int {
    case stopped = 0
    case playing = 1
    case paused = 2
    case interrupted = 3
    case seekingForward = 4
    case seekingBackward = 5
}
