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
    let onAddTapped: (() -> Void)?
    
    // MARK: Init
    
    init(
        items: [Item],
        selectedItem: Item?,
        title: String,
        icon: @escaping (Item) -> Image,
        text: @escaping (Item) -> String,
        onSelect: @escaping (Item?) -> Void,
        onAddTapped: (() -> Void)? = nil
    ) {
        self.items = items
        self.selectedItem = selectedItem
        self.title = title
        self.icon = icon
        self.text = text
        self.onSelect = onSelect
        self.onAddTapped = onAddTapped
    }

    // MARK: - UI

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                if onAddTapped != nil {
                    Button {
                        self.onAddTapped?()
                    } label: {
                        Image(systemName: "plus")
                            .font(.subheadline)
                            .opacity(0.8)
                            .foregroundStyle(Color.secondary)
                            .padding(5)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            
            ZStack {
                itemsScroll
                    .opacity(items.isEmpty ? 0 : 1)

                emptyState
                    .opacity(items.isEmpty ? 1 : 0)
            }
            .frame(minHeight: 86)
            .animation(.smooth, value: items.count)
        }
        .animation(.smooth, value: items.count)
    }
    
    private var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "tray")
                .font(.system(size: 28))
                .foregroundColor(.secondary)
                .opacity(0.6)

            Text("No items yet")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var itemsScroll: some View {
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

