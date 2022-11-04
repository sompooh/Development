//
//  MiniPlayer.swift
//  MusicPlayer
//
//  Created by USER on 2022/11/04.
//

import SwiftUI

struct MiniPlayer: View {
    var animation: Namespace.ID
    @Binding var expand: Bool
    @State var volume: CGFloat = 0
    @State var currentTime: CGFloat = 0
    @State var gestureOffset: CGFloat = 0
    
    private var safeAreaInsetTop: CGFloat {
//        UIApplication.shared.windows.first?.safeAreaInsets.top ?? .zero
        return .zero
    }
    
    var body: some View {
        VStack {
            if expand {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 8)
                    .cornerRadius(4)
                    .padding()
                    .opacity(expand ? 1 : 0)
            }
            HStack {
                if !expand {
                    Button(action: {}) {
                        ZStack {
                            Color.clear.frame(width: 44, height: 44)
                            Image(systemName: "play.fill")
                                .font(.system(size: 25))
                        }
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 3) {
                        Text("라일락")
                            .font(.system(size: 15, weight: .bold))
                            .matchedGeometryEffect(id: "TitleLabel", in: animation)
                        Text("아이유")
                            .font(.system(size: 14, weight: .semibold))
                            .matchedGeometryEffect(id: "SubTitleLabel", in: animation)
                    }
                    Spacer()
                }
                
                Image("albumCover")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: expand ? 300 : 44, height: expand ? 300 : 44)
                    .cornerRadius(10)
            }
            .padding(20)
            
            VStack {
                if expand {
                    HStack {
                        VStack(alignment: .center, spacing: 3) {
                            Text("라일락")
                                .font(.system(size: 15, weight: .bold))
                                .matchedGeometryEffect(id: "TitleLabel", in: animation)
                            Text("아이유")
                                .font(.system(size: 14, weight: .semibold))
                                .matchedGeometryEffect(id: "SubTitleLabel", in: animation)
                        }
                    }
                    .padding()
                    
                    HStack {
                        Button(action: {}) {
                            ZStack {
                                Color.clear.frame(width: 44, height: 44)
                                Image(systemName: "repeat")
                                    .font(.system(size: 25))
                            }
                        }
                        Spacer()
                        Button(action: {}) {
                            ZStack {
                                Color.clear.frame(width: 44, height: 44)
                                Image(systemName: "backward.fill")
                                    .font(.system(size: 30))
                            }
                        }
                        Spacer()
                        Button(action: {}) {
                            ZStack {
                                Color.clear.frame(width: 44, height: 44)
                                Image(systemName: "play.fill")
                                    .font(.system(size: 40))
                            }
                        }
                        Spacer()
                        Button(action: {}) {
                            ZStack {
                                Color.clear.frame(width: 44, height: 44)
                                Image(systemName: "forward.fill")
                                    .font(.system(size: 30))
                            }
                        }
                        Spacer()
                        Button(action: {}) {
                            ZStack {
                                Color.clear.frame(width: 44, height: 44)
                                Image(systemName: "shuffle")
                                    .font(.system(size: 25))
                            }
                        }
                    }
                    .padding(20)
                
                    Slider(value: $volume)
                        .padding(20)
                    Slider(value: $currentTime)
                        .padding(20)
                    
                    Spacer()
                }
            }
            .frame(width: expand ? nil : 0, height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: expand ? .infinity : 64)
        .background(
            VStack(spacing: 0) {
                Color.white
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    expand = true
                }
            }
        )
        .cornerRadius(10)
        .offset(y: gestureOffset)
        .gesture(DragGesture()
            .onEnded({ value in
                if value.translation.height > 100 {
                    expand = false
                }
                gestureOffset = 0
            }).onChanged({ value in
                if value.translation.height > 0 && expand {
                    gestureOffset = value.translation.height
                }
            }))
    }
}
