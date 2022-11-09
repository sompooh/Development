//
//  DefaultNavigationView.swift
//  MusicPlayApp
//
//  Created by USER on 2022/11/09.
//  Copyright © 2022 com.som.tuist.music. All rights reserved.
//

import SwiftUI

struct DefaultNavigationView<Content>: View where Content: View {
    private let title: String
    private let displayMode: NavigationBarItem.TitleDisplayMode
    private let content: () -> Content
    
    init(title: String, displayMode: NavigationBarItem.TitleDisplayMode, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.displayMode = displayMode
        self.content = content
    }
    
    var body: some View {
        NavigationView {
            content()
                .navigationBarTitle(title, displayMode: displayMode)
        }
        .navigationViewStyle(.stack)
    }
}
