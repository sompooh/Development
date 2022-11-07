//
//  AlbumsView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import Domain
import SwiftUI

struct AlbumsView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @EnvironmentObject var albumViewModel: AlbumViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
                    ForEach(albumViewModel.albumList, id: \.self) { album in
                        NavigationLink(destination: AlbumEndView(album: album).environmentObject(albumViewModel), label: {
                            AlbumCardView(album: album)
                        })
                    }
                }
                .padding(20)
                .padding(.bottom, 64)
            }
        }
    }
}
