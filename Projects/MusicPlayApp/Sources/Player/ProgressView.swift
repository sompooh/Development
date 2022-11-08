//
//  ProgressView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/06.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

struct ProgressBarView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @State private var currentTime: CGFloat = 0.0
    var isExpand: Bool
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            ProgressView("", value: currentTime, total: playerViewModel.currentDuration ?? 1)
            if isExpand {
                HStack {
                    Text(TimeInterval(currentTime).positionalTime)
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Text(playerViewModel.currentDuration?.positionalTime ?? "00:00")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.top, 3)
            }
        }
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

extension TimeInterval {
    struct DateComponents {
        static let formatterPositional: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            return formatter
        }()
    }
    var positionalTime: String {
        DateComponents.formatterPositional.allowedUnits = self >= 3600 ?
                                                    [.hour, .minute, .second] :
                                                    [.minute, .second]
        return DateComponents.formatterPositional.string(from: self) ?? "00:00"
    }
}
