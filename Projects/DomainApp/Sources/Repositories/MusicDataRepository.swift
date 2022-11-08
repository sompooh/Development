//
//  MusicDataRepository.swift
//  DomainApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.domain. All rights reserved.
//

import Foundation
import Combine

public protocol MusicDataRepository {
    func fetchAlbumList() -> AnyPublisher<[Album], Error>
}
