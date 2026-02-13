//
//  IconItemView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import SwiftUI

struct IconItemView: View {

    // MARK: Props

    let icon: String
    let isSelected: Bool

    // MARK: UI

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? Color.appPrimary.opacity(0.2) : Color.gray.opacity(0.1))
                .frame(height: 56)

            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isSelected ? Color.appPrimary : .clear,
                    lineWidth: 2
                )
        }
    }
}
