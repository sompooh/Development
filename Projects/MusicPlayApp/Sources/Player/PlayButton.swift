//
//  PlayButton.swift
//  MusicPlayApp
//
//  Created by 김유미 on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI

struct PlayButton: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    var fontSize: CGFloat
    var color: Color
    
    var body: some View {
        Button(action: {
            if playerViewModel.musicPlayer.playbackState == .paused || playerViewModel.musicPlayer.playbackState == .stopped {
                playerViewModel.musicPlayer.play()
                withAnimation {
                    playerViewModel.isPlaying = true
                }
            } else {
                playerViewModel.musicPlayer.pause()
                withAnimation {
                    playerViewModel.isPlaying = false
                }
            }
        }) {
            ZStack {
                Color.clear.frame(width: 44, height: 44)
                Image(systemName: playerViewModel.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: fontSize))
                    .foregroundColor(color)
            }
        }
    }
}
