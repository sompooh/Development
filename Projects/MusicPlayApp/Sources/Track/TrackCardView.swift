//
//  TrackCardView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct TrackCardView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    let song: MPMediaItem
    
    var body: some View {
        HStack {
            Image(uiImage: song.artwork?.image(at: CGSize(width: 300, height: 300)) ??  UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(song.title ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                Text(song.artist ?? "")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black.opacity(0.5))
            }
            Spacer()
        }
        .onTapGesture {
            playerViewModel.musicPlayer.setQueue(with: MPMediaItemCollection(items: [song]))
            playerViewModel.musicPlayer.play()
            withAnimation {
                playerViewModel.isPlaying = true
            }
        }
    }
}
