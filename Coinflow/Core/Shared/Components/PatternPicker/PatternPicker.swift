//
//  PatternPicker.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.12.2025.
//

import Foundation
import SwiftUI

struct PatternPicker: View {

    // MARK: Props

    @Binding var selectedPattern: String?
    var action: (String?) -> Void

    private let patterns: [String] = [
        "hexagons",
        "lips",
        "topography",
        "hideout",
        "falling-triangles",
        "charlie-brown",
        "brick-wall"
    ]

    // MARK: UI

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button {
                    selectedPattern = nil
                    action(nil)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                selectedPattern == nil ? Color.blue : Color.gray.opacity(0.3),
                                lineWidth: 2
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemGray6))
                            )

                        Image(systemName: "circle.slash")
                            .font(.system(size: 12))
                            .foregroundColor(selectedPattern == nil ? .blue : .gray)
                    }
                    .frame(width: 50, height: 50)
                }

                ForEach(patterns, id: \.self) { pattern in
                    Button {
                        selectedPattern = pattern
                        action(pattern)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    selectedPattern == pattern ? Color.blue : Color.gray.opacity(0.3),
                                    lineWidth: 2
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemBackground))
                                )

                            Image(pattern)
                                .resizable(resizingMode: .tile)
                                .renderingMode(.template)
                                .foregroundColor(.appPrimary.opacity(0.9))
                                .cornerRadius(6)
                        }
                        .frame(width: 100, height: 50)
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 2)
        }
    }
}
