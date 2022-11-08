//
//  MPMusicRepository.swift
//  DataApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.data. All rights reserved.
//

import Combine
import Domain
import UIKit
import MediaPlayer

final public class MPMusicRepository {
    private let dataStorage: MusicStorage
    private let fetchImageSize: CGSize = CGSize(width: 300, height: 300)
    public init(dataStorage: MusicStorage) {
        self.dataStorage = dataStorage
    }
}
    
extension MPMusicRepository: MusicDataRepository {
    public func fetchAlbumList() -> AnyPublisher<[Album], Error> {
        return dataStorage.fetchAlbumList()
            .subscribe(on: DispatchQueue.global())
            .flatMap { result -> AnyPublisher<[Album], Error> in
                let albums = result.map { Album(mediaItem: $0) }
                return Result<[Album], Error>.success(albums)
                    .publisher.eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
