//
//  ContentView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/05.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @EnvironmentObject var albumViewModel: AlbumViewModel
    @Namespace var animation
    
    var body: some View {
        ZStack {
            AlbumsView()
                .environmentObject(playerViewModel)
                .environmentObject(albumViewModel)
                .zIndex(1)
            
            ZStack(alignment: .bottom) {
                if playerViewModel.isPlayerViewExpand {
                    FullPlayerView(animation: animation)
                        .environmentObject(playerViewModel)
                } else {
                    MiniPlayerView(animation: animation)
                        .environmentObject(playerViewModel)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .zIndex(2)
        }
        
    }
}
