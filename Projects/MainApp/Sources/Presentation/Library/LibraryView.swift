//
//  ContentView.swift
//  MusicPlayer
//
//  Created by USER on 2022/11/05.
//

import SwiftUI
import UIKit

struct LibraryView: View {
    private var safeAreaInsetBottom: CGFloat {
//        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? .zero
        return .zero
    }

    var body: some View {
        DefaultNavigationView(title: "Library", displayMode: .large) {
            ScrollView {
                    GridView(columns: 3, items: ["1", "2", "3", "4", "5", "6", "1", "2", "3", "4", "5", "6", "1", "2", "3", "4", "5", "6", "1", "2", "3", "4", "5", "6"], spacing: 20) { item in
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.blue)
                                .frame(height: 100)
                            Text(item)
                                .font(.body)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(20)
                    .background(Color.white)
            }
            .padding(.bottom, 64)
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}


