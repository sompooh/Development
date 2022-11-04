//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by USER on 2022/11/05.
//

import SwiftUI
import MediaPlayer

@main
struct MusicPlayerApp: App {
    let storage = LocalTrackListStorage()
    
    @State var expand = false
    @Namespace var animation
    
    init() {
        NavigationBarConfigure.setColors(background: UIColor(red: 0.3, green: 0.6, blue: 0.9, alpha: 1), titleColor: .white, tintColor: .white)
    }

    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                LibraryView()
                    .onAppear(perform: { storage.checkAuthorization() })
                    .AuthorizaionViewSheet()
                MiniPlayer(animation: animation, expand: $expand)
            }
        }
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
