//
//  DefaultMusicFetchUseCase.swift
//  DomainApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.domain. All rights reserved.
//

import Foundation
import Combine

public final class DefaultMusicFetchUseCase: MusicFetchUseCase {
    
    let repository: MusicDataRepository
    
    public init(repository: MusicDataRepository) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<[Album], Error> {
        return repository.fetchAlbumList()
    }
}
