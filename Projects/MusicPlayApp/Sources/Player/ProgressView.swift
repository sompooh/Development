//
//  ProgressView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI
import Combine

struct ProgressBarView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @State private var currentTime: CGFloat = 0.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ProgressView("", value: currentTime, total: playerViewModel.currentDuration ?? 1)
            .onReceive(timer) { _ in
                if currentTime != playerViewModel.currentTime {
                    currentTime = playerViewModel.currentTime
                }
                if !playerViewModel.isPlaying {
                    timer.upstream.connect().cancel()
                }
            }
    }
}
