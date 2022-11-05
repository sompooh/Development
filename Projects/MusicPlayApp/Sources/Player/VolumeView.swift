//
//  VolumeView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/07.
//  Copyright © 2022 com.nami.tuist.data. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct VolumeView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        MPVolumeView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
