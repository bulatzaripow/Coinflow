//
//  HorizontalItemPicker.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.01.2026.
//

import SwiftUI

struct HorizontalItemPicker<Item: Identifiable>: View {

    // MARK: - Props

    let items: [Item]
    let selectedItem: Item?
    let title: String

    let icon: (Item) -> Image
    let text: (Item) -> String
    let onSelect: (Item?) -> Void

    // MARK: - UI

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.headline)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {

                    ForEach(items) { item in
                        let isSelected = selectedItem?.id == item.id

                        Button {
                            withAnimation(.easeInOut(duration: 0.15)) {
                                onSelect(isSelected ? nil : item)
                            }
                        } label: {
                            VStack(spacing: 6) {

                                ZStack {
                                    Circle()
                                        .stroke(
                                            isSelected ? Color.appPrimary : .clear,
                                            lineWidth: 2
                                        )
                                        .frame(width: 48, height: 48)

                                    Circle()
                                        .fill(Color(.systemGray6))
                                        .frame(width: 44, height: 44)

                                    icon(item)
                                        .resizable()
                                        .renderingMode(.template)
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(
                                            isSelected ? .appPrimary : .primary
                                        )
                                }

                                Text(text(item))
                                    .font(.caption)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 60, height: 32, alignment: .top)
                                    .foregroundColor(.primary)
                            }
                            .frame(width: 60)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 2)
            }
        }
    }
}

