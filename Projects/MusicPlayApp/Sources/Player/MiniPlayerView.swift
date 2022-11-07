//
//  MiniPlayerView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI

struct MiniPlayerView: View {
    var animation: Namespace.ID
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    private let emptyArtwork = UIImage(named: "placeholder") ?? UIImage()
    private var safeAreaInset: UIEdgeInsets? {
        UIApplication.shared.windows.first?.safeAreaInsets
    }
    
    var body: some View {
        let currentTrack = playerViewModel.currentTrack
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            VStack(spacing: 0) {
                ProgressBarView()
                    .environmentObject(playerViewModel)
                    .matchedGeometryEffect(id: "player.progress", in: animation)
                HStack() {
                    Image(uiImage: currentTrack?.artworkImage ?? emptyArtwork)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .matchedGeometryEffect(id: "player.artWork", in: animation)
                        .cornerRadius(4)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                    VStack(alignment: .leading) {
                        if let currentTrack = currentTrack {
                            Text(currentTrack.title ?? "")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                            Text(currentTrack.artist ?? "")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                        } else {
                            Text("재생 중인 곡이 없습니다.")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .matchedGeometryEffect(id: "player.info", in: animation)
                    Spacer(minLength: 0)
                    HStack {
                        PlayButton(fontSize: 30, color: .white)
                            .matchedGeometryEffect(id: "player.button", in: animation)
                        Button(action: {
                            playerViewModel.musicPlayer.skipToNextItem()
                        }) {
                            Image(systemName: "forward.fill")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(10)
                }
            }
            
            .frame(height: 64)
            .padding(.bottom, (safeAreaInset?.bottom ?? 0))
            .background(
                VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
                    .matchedGeometryEffect(id: "player.background", in: animation)
            )
        }
        .onTapGesture {
            withAnimation(.spring()) {
                playerViewModel.isPlayerViewExpand = true
            }
        }
    }
}
