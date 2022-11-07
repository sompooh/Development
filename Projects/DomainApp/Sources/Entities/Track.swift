//
//  Track.swift
//  DomainApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.domain. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

public struct Track: Hashable {
    public let id: String
    public let title: String?
    public let artist: String?
    public let artworkImage: UIImage?
    public let playDuration: CGFloat?
    
    public init() {
        id = ""
        title = nil
        artist = nil
        artworkImage = nil
        playDuration = nil
    }
    
    public init(id: String, title: String?, artist: String?, artworkImage: UIImage?, playDuration: CGFloat?) {
        self.id = id
        self.title = title
        self.artist = artist
        self.artworkImage = artworkImage
        self.playDuration = playDuration
    }
    
    public init(mediaItem: MPMediaItem) {
        id = String(mediaItem.persistentID)
        title = mediaItem.title
        artist = mediaItem.artist
        artworkImage = mediaItem.artwork?.image(at: CGSize(width: 300, height: 300))
        playDuration = mediaItem.playbackDuration
    }
}
