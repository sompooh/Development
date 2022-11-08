//
//  AlbumCardView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import Domain
import SwiftUI

struct AlbumCardView: View {
    let album: Album
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(uiImage: album.artworkImage ?? UIImage())
                .resizable()
                .aspectRatio(1, contentMode: .fit)
            HStack {
                VStack(alignment: .leading) {
                    Text(album.title ?? "")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                    Text(album.artist ?? "")
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

