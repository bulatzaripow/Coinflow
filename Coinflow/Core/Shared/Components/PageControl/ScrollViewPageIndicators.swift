//
//  ScrollViewPageIndicators.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 27.12.2025.
//

import SwiftUI

struct ScrollViewPageIndicators: View {
    let count: Int
    let scrollProgressX: Double
    let maxVisibleDots = 15
    let hideIfSinglePage: Bool = true
    let spacing: CGFloat = 8

    var shouldTruncate: Bool {
        count > maxVisibleDots
    }

    var body: some View {
        HStack(spacing: spacing) {
            if shouldTruncate {
                let startIndex = max(Int(scrollProgressX.rounded()) - maxVisibleDots/2, 0)
                let endIndex = min(startIndex + maxVisibleDots, count)

                ForEach(startIndex..<endIndex, id: \.self) { index in
                    Circle()
                        .fill(index == Int(scrollProgressX.rounded()) ? Color.primary : Color.secondary.opacity(0.5))
                        .frame(width: 6, height: 6)
                        .animation(.easeInOut(duration: 0.3), value: scrollProgressX)
                }
            } else {
                ForEach(0..<count, id: \.self) { index in
                    Circle()
                        .fill(index == Int(scrollProgressX.rounded()) ? Color.primary : Color.secondary.opacity(0.5))
                        .frame(width: 6, height: 6)
                        .animation(.easeInOut(duration: 0.3), value: scrollProgressX)
                }
            }
        }
        .frame(height: 8)
    }
}
