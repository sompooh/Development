//
//  AlbumCardView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct AlbumCardView: View {
    let album: MPMediaItemCollection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(uiImage: album.representativeItem?.artwork?.image(at: CGSize(width: 300, height: 300)) ??  UIImage())
                .resizable()
                .aspectRatio(1, contentMode: .fit)
            HStack {
                VStack(alignment: .leading) {
                    Text(album.representativeItem?.albumTitle ?? "")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                    Text(album.representativeItem?.albumArtist ?? "")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                }
                Spacer(minLength: 0)
            }
            .padding(10)
            .background(Color.black.opacity(0.8))
        }
        .cornerRadius(10)
    }
}

