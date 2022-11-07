//
//  AlbumListStorage.swift
//  DataApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.data. All rights reserved.
//

import Combine
import MediaPlayer

public protocol MusicStorage {
    func fetchAlbumList() -> AnyPublisher<[MPMediaItemCollection], Error>
}
