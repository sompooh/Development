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
        let currentTrack = playerViewModel.currentTrack
        VStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 40, height: 8)
                .cornerRadius(4)
                .matchedGeometryEffect(id: "player.handleview", in: animation)
                .padding()
            Spacer(minLength: 0)
            Image(uiImage: currentTrack?.artworkImage ?? emptyArtwork)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(10)
                .matchedGeometryEffect(id: "player.artWork", in: animation)
                .padding(20)
            VStack {
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
            .padding(.bottom, 20)
            ProgressBarView(isExpand: true)
                .environmentObject(playerViewModel)
                .matchedGeometryEffect(id: "player.progress", in: animation)
                .padding(20)
            HStack {
                Button(action: {
                    playerViewModel.changeRepeatMode()
                }) {
                    ZStack {
                        Color.clear.frame(width: 44, height: 44)
                        switch playerViewModel.musicPlayer.repeatMode {
                        case .all:
                            Image(systemName: "repeat").foregroundColor(.white).font(.system(size: 20))
                        case .one:
                            Image(systemName: "repeat.1").foregroundColor(.white).font(.system(size: 20))
                        default:
                            Image(systemName: "repeat").foregroundColor(.white.opacity(0.5)).font(.system(size: 20))
                        }
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
                Button(action: {
                    playerViewModel.changeShuffleMode()
                }) {
                    ZStack {
                        Color.clear.frame(width: 44, height: 44)
                        switch playerViewModel.musicPlayer.shuffleMode {
                        case .off, .default:
                            Image(systemName: "shuffle").foregroundColor(.white.opacity(0.5)).font(.system(size: 20))
                        default:
                            Image(systemName: "shuffle").foregroundColor(.white).font(.system(size: 20))
                        }
                    }
                }
            }
            .matchedGeometryEffect(id: "player.button", in: animation)
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
