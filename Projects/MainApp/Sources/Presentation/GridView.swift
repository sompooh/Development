//
//  GridView.swift
//  MusicPlayer
//
//  Created by USER on 2022/11/05.
//

import SwiftUI

struct GridView<Content, T>: View where Content: View {
    private var columns: Int
    private var items: [T]
    private let content: (T) -> Content
    private let spacing: CGFloat
    
    var numberRows: Int { (items.count - 1) / columns }
    
    init(columns: Int, items: [T], spacing: CGFloat, @ViewBuilder content: @escaping (T) -> Content) {
        self.columns = columns
        self.items = items
        self.content = content
        self.spacing = spacing
    }
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0...numberRows, id: \.self) { row in
                HStack(spacing: spacing) {
                    Group {
                        ForEach(0..<columns, id: \.self) { column in
                            if let index = elementFor(row: row, column: column),
                               let item = items[index] {
                                content(item)
                                    .fixedSize(horizontal: false, vertical: true)
                            } else {
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func elementFor(row: Int, column: Int) -> Int? {
        let index = row * columns + column
        return index < items.count ? index : nil
    }
}
