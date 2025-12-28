//
//  AccountCarouselView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 28.12.2025.
//

import SwiftUI
import SwiftData

struct AccountCarouselView: View {
    
    // MARK: - Props
    
    let accounts: [Account]
    @State private var scrollProgressX: CGFloat = 0
    @State private var selectedAccount: Account?
    
    private let spacing: CGFloat = 10
    
    private var allCards: [CardType] {
        var cards: [CardType] = []

        cards.append(contentsOf: accounts.map { .account($0) })
        cards.append(.addAccount)
        
        return cards
    }
    
    var addAccountAction: () -> Void = { }
    
    // MARK: - UI
    
    var body: some View {
        VStack(spacing: 15) {
            if allCards.isEmpty {
                ContentUnavailableView(
                    "No accounts",
                    systemImage: "creditcard"
                )
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: spacing) {
                        ForEach(Array(allCards.enumerated()), id: \.offset) { index, cardType in
                            switch cardType {
                            case .account(let account):
                                AccountCardView(account: account)
                                    .onTapGesture {
                                        selectedAccount = account
                                    }
                            case .addAccount:
                                AddAccountCardView() {
                                    addAccountAction()
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(.horizontal, 20, for: .scrollContent)
                .frame(height: 160)
                .scrollClipDisabled()
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
                .onScrollGeometryChange(for: CGFloat.self) { geometry in
                    let offsetX = geometry.contentOffset.x + geometry.contentInsets.leading
                    let cardWidth = (UIScreen.main.bounds.width - 20)
                    let totalWidth = cardWidth + spacing
                    
                    return offsetX / totalWidth
                } action: { oldValue, newValue in
                    let maxValue = CGFloat(max(allCards.count, 0))
                    scrollProgressX = min(max(newValue, 0), maxValue)
                }
                
                // Page indicators
                ScrollViewPageIndicators(
                    count: allCards.count,
                    scrollProgressX: scrollProgressX
                )
            }
        }
        .padding(.vertical, 10)
    }
}

// MARK: - Constants

extension AccountCarouselView {
    private enum CardType {
        case account(Account)
        case addAccount
    }
}
