//
//  TrackListStorage.swift
//  MusicPlayer
//
//  Created by USER on 2022/11/05.
//

import Combine
import MediaPlayer

protocol TrackListStorage {
    func fetchTrackList() -> AnyPublisher<[Track], Error>
}

final class LocalTrackListStorage {
    
    private var musicAuthorizationStatusObserver: AnyCancellable?
    
    init() {
        
    }
    
    
    private func requestAuthorizationForMediaLibrary() async -> Bool {
        var status = MPMediaLibrary.authorizationStatus()
        guard status == .notDetermined else {
            return status == .authorized
        }
        status = await MPMediaLibrary.requestAuthorization()
        return status == .authorized
    }
    
    func checkAuthorization() {
        Task {
            let isAuthorized = await requestAuthorizationForMediaLibrary()
            print("### \(isAuthorized)")
        }
    }
}
