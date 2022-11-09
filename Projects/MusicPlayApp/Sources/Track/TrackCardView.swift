//
//  TrackCardView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import Domain
import SwiftUI

struct TrackCardView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    let track: Track
    
    var body: some View {
        HStack {
            Image(uiImage: track.artworkImage ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(track.title ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                Text(track.artist ?? "")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black.opacity(0.5))
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            playerViewModel.play(track: track)
            withAnimation {
                playerViewModel.isPlaying = true
            }
        }
    }
}
