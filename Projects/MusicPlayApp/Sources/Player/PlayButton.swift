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
            if playerViewModel.playbackState == .paused || playerViewModel.playbackState == .stopped {
                playerViewModel.play()
                withAnimation {
                    playerViewModel.isPlaying = true
                }
            } else {
                playerViewModel.pause()
                withAnimation {
                    playerViewModel.isPlaying = false
                }
            }
        }) {
            ZStack {
                Color.clear.frame(width: 44, height: 44)
                Image(systemName: playerViewModel.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: fontSize))
                    .foregroundColor(playerViewModel.currentTrack != nil ? .white : .gray)
            }
        }
        .disabled(playerViewModel.currentTrack == nil)
    }
}
