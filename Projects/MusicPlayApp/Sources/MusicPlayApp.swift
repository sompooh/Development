//
//  MusicPlayApp.swift
//  MusicPlayer
//
//  Created by USER on 2022/11/05.
//

import SwiftUI
import MediaPlayer

@main
struct MusicPlayApp: App {
    @ObservedObject var playerViewModel = PlayerViewModel.shared
    
    init() {
        NavigationBarConfigure.setColors(background: UIColor(red: 0.3, green: 0.6, blue: 0.9, alpha: 1), titleColor: .white, tintColor: .white)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(playerViewModel)
                .onAppear(perform: {
                    Task {
                        let isAuthorized = await requestAuthorizationForMediaLibrary()
                        guard isAuthorized else {
                            return
                        }
                        playerViewModel.fetchSongs()
                    }
                })
        }
    }
    
    private func requestAuthorizationForMediaLibrary() async -> Bool {
        var status = MPMediaLibrary.authorizationStatus()
        guard status == .notDetermined else {
            return status == .authorized
        }
        status = await MPMediaLibrary.requestAuthorization()
        return status == .authorized
    }
}



class NavigationBarConfigure {
    static func setColors(background: UIColor?,
       titleColor: UIColor? = nil, tintColor: UIColor? = nil){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.shadowImage = nil
        navigationAppearance.shadowColor = .clear
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}
