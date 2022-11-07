//
//  AlbumViewModel.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.som.tuist.music. All rights reserved.
//

import Combine
import Domain
import UIKit

protocol AlbumViewModelInput {
    func executeFetch()
}
protocol AlbumViewModelOutput {
    var albumList: [Album] { get }
}

class AlbumViewModel: ObservableObject, AlbumViewModelInput, AlbumViewModelOutput {
    let fetchUseCase: MusicFetchUseCase
    @Published var albumList: [Album] = []
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(useCase fetchUseCase: MusicFetchUseCase) {
        self.fetchUseCase = fetchUseCase
    }
    
    func executeFetch() {
        fetchUseCase.execute()
            .sink { response in
                switch response {
                case .finished:
                    break
                case .failure(_):
                    self.albumList = []
                }
            } receiveValue: { albumList in
                DispatchQueue.main.async {
                    self.albumList = albumList
                }
            }
            .store(in: &bag)
    }
}
