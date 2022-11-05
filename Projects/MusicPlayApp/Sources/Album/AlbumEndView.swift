//
//  AlbumEndView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct AlbumEndView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    let album: MPMediaItemCollection
    
    var body: some View {
        List {
            VStack(spacing: 0) {
                Image(uiImage: album.representativeItem?.artwork?.image(at: CGSize(width: 300, height: 300)) ??  UIImage())
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(10)
                    .padding(20)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(album.representativeItem?.albumTitle ?? "")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                        .padding(.bottom, 3)
                    Text(album.representativeItem?.albumArtist ?? "")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black.opacity(0.5))
                        .padding([.leading, .bottom], 20)
                    HStack {
                        Button(action: {
                        }) {
                            Image(systemName: "play.fill")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        
                        Button(action: {
                        }) {
                            Image(systemName: "shuffle")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.bottom, 10)
                
            ForEach(album.items, id: \.self) { song in
                TrackCardView(song: song)
                    .environmentObject(playerViewModel)
            }
        }
        .padding(.bottom, 64)
        .listStyle(PlainListStyle())
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}
