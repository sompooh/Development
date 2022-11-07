//
//  AlbumEndView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import Domain
import SwiftUI
import MediaPlayer

struct AlbumEndView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @EnvironmentObject var albumViewModel: AlbumViewModel
    let album: Album
    
    var body: some View {
        List {
            VStack(spacing: 0) {
                Image(uiImage: album.artworkImage ??  UIImage())
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(10)
                    .padding(20)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(album.title ?? "")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                        .padding(.bottom, 3)
                    Text(album.artist ?? "")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black.opacity(0.5))
                        .padding([.leading, .bottom], 20)
                    HStack {
                        Button(action: {
                            guard let track = album.trackList?.first else { return }
                            playerViewModel.play(track: track)
                        }) {
                            ZStack {
                                Color.clear.frame(maxWidth: .infinity)
                                Image(systemName: "play.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(height: 44)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        
                        Button(action: {
                            guard let track = album.trackList?.randomElement() else { return }
                            playerViewModel.musicPlayer.shuffleMode = .songs
                            playerViewModel.play(track: track)
                        }) {
                            ZStack {
                                Color.clear.frame(maxWidth: .infinity)
                                Image(systemName: "shuffle")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(height: 44)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.bottom, 10)
                
            ForEach(album.trackList ?? [], id: \.self) { track in
                TrackCardView(track: track)
                    .environmentObject(playerViewModel)
            }
        }
        .padding(.bottom, 64)
        .listStyle(PlainListStyle())
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}
