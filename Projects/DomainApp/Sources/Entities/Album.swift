//
//  Album.swift
//  DomainApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.domain. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

public struct Album: Hashable {
    public let id: String
    public let title: String?
    public let artist: String?
    public let trackList: [Track]?
    public let artworkImage: UIImage?
    
    public init() {
        id = ""
        title = nil
        artist = nil
        artworkImage = nil
        trackList = nil
    }
    
    public init(id: String, title: String?, artist: String?, artworkImage: UIImage?, trackList: [Track]?) {
        self.id = id
        self.title = title
        self.artist = artist
        self.artworkImage = artworkImage
        self.trackList = trackList
    }
    
    public init(mediaItem: MPMediaItemCollection) {
        id = String(mediaItem.persistentID)
        title = mediaItem.representativeItem?.albumTitle ?? ""
        artist = mediaItem.representativeItem?.albumArtist ?? ""
        artworkImage = mediaItem.representativeItem?.artwork?.image(at: CGSize(width: 300, height: 300))
        trackList = mediaItem.items.map { Track(mediaItem: $0) }
    }
}

