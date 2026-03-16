//
//  AddAccountCardView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 27.12.2025.
//

import SwiftUI

struct AddAccountCardView: View {

    // MARK: - Props

    @Environment(\.colorScheme) private var colorScheme

    var action: () -> Void

    // MARK: - UI

    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)

                Text("Add account")
                    .font(.headline)
            }
            .frame(minHeight: 160)
            .containerRelativeFrame(.horizontal)
            .foregroundColor(
                Color(
                    UIColor { traitCollection in
                        traitCollection.userInterfaceStyle == .dark
                            ? .white
                            : UIColor(.appPrimary)
                    }
                )
            )
            .background(Color.init(.tertiarySystemBackground))
            .cornerRadius(15)
            .shadow(
                color: colorScheme == .light ? .gray.opacity(0.3) : .clear,
                radius: 10,
                y: 5
            )
        }
    }
}
