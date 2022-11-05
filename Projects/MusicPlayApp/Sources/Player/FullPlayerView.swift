//
//  FullPlayerView.swift
//  MusicPlayApp
//
//  Created by 김유미 on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI

struct FullPlayerView: View {
    var animation: Namespace.ID
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @State var gestureOffset: CGFloat = 0
    
    private let emptyArtwork = UIImage(named: "placeholder") ?? UIImage()
    
    var body: some View {
        let currentSong = playerViewModel.currentSong
        VStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 40, height: 8)
                .cornerRadius(4)
                .padding()
            Spacer(minLength: 0)
            Image(uiImage: currentSong?.artwork?.image(at: CGSize(width: 300, height: 300)) ?? emptyArtwork)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .matchedGeometryEffect(id: "player.artWork", in: animation)
                .cornerRadius(10)
                .padding(20)
            VStack {
                if let currentSong = currentSong {
                    Text(currentSong.title ?? "")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                    Text(currentSong.artist ?? "")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                } else {
                    Text("재생 중인 곡이 없습니다.")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .matchedGeometryEffect(id: "player.info", in: animation)
            .padding(.bottom, 20)
            ProgressBarView()
                .environmentObject(playerViewModel)
                .matchedGeometryEffect(id: "player.progress", in: animation)
                .padding(20)
            HStack {
                Button(action: {}) {
                    ZStack {
                        Color.clear.frame(width: 44, height: 44)
                        Image(systemName: "repeat")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                Button(action: {
                    playerViewModel.musicPlayer.skipToPreviousItem()
                }) {
                    ZStack {
                        Color.clear.frame(width: 44, height: 44)
                        Image(systemName: "backward.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                PlayButton(fontSize: 40, color: .white)
                    .matchedGeometryEffect(id: "player.button", in: animation)
                Spacer()
                Button(action: {
                    playerViewModel.musicPlayer.skipToNextItem()
                }) {
                    ZStack {
                        Color.clear.frame(width: 44, height: 44)
                        Image(systemName: "forward.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                Button(action: {}) {
                    ZStack {
                        Color.clear.frame(width: 44, height: 44)
                        Image(systemName: "shuffle")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(20)
            VolumeView()
                .padding(20)
            Spacer(minLength: 0)
        }
        .background(
            VisualEffectView(effect: UIBlurEffect(style: .dark))
                .matchedGeometryEffect(id: "player.background", in: animation)
        )
        .cornerRadius(10)
        .offset(y: gestureOffset)
        .gesture(DragGesture()
            .onEnded({ value in
                if value.translation.height > 100 {
                    withAnimation(.spring()) {
                        playerViewModel.isPlayerViewExpand = false
                    }
                }
                gestureOffset = 0
                
            }).onChanged({ value in
                if value.translation.height > 0 && playerViewModel.isPlayerViewExpand {
                    gestureOffset = value.translation.height
                }
            }))
    }
}
