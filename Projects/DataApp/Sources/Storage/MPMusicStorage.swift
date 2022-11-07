//
//  MPMusicStorage.swift
//  DataApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.data. All rights reserved.
//

import Combine
import MediaPlayer

enum MuiscStorageError: Error {
    case unknown
    case authorization
}

final public class MPMusicStorage: MusicStorage {
    private var isAuthorizedForMediaLibrary: Bool {
        MPMediaLibrary.authorizationStatus() == .authorized
    }

    public init() {}
    
    public func fetchAlbumList() -> AnyPublisher<[MPMediaItemCollection], Error> {
        guard isAuthorizedForMediaLibrary else {
            return Result<[MPMediaItemCollection], Error>
                .failure(MuiscStorageError.authorization)
                .publisher
                .eraseToAnyPublisher()
        }
        let albumsQuery = MPMediaQuery.albums()
        if let albums = albumsQuery.collections {
            return Result<[MPMediaItemCollection], Error>
                .success(albums)
                .publisher
                .eraseToAnyPublisher()
        } else {
            return Result<[MPMediaItemCollection], Error>
                .failure(MuiscStorageError.unknown)
                .publisher
                .eraseToAnyPublisher()
        }
    }
}
