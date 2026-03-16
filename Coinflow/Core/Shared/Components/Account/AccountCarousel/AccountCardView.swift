//
//  AccountCardView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI

struct AccountCardView: View {

    // MARK: - Props

    @Environment(\.colorScheme) private var colorScheme

    let account: AccountDraft

    // MARK: - UI

    var body: some View {
        ZStack {
            if let gradient = account.backgroundColor?.gradient {
                gradient
            } else {
                Color(.tertiarySystemBackground)
            }

            if let pattern = account.backgroundPattern {
                Image(pattern)
                    .resizable(resizingMode: .tile)
                    .renderingMode(.template)
                    .foregroundColor(
                        colorScheme == .dark ?
                            .white.opacity(0.1) :
                            .appPrimary.opacity(0.2)
                    )
            }

            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Total Balance")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(account.name.isEmpty ? "Default" : account.name)
                            .font(.headline)

                        Text(String(CurrencyFormatter.format(account.balance, currency: account.currency)))
                            .font(.system(size: 28, weight: .bold))
                    }

                    Spacer()
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .foregroundColor(account.backgroundColor != nil ? .white : .primary)
        }
        .frame(maxWidth: .infinity, maxHeight: 160)
        .containerRelativeFrame(.horizontal)
        .background(.white)
        .cornerRadius(15)
    }
}
