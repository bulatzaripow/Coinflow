//
//  AccountCarouselTabView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI

struct AccountCarouselTabView: View {
    let accounts: [Account]
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TabView(selection: $selectedIndex) {
                ForEach(Array(accounts.enumerated()), id: \.element.id) { index, account in
                    AccountCardView(account: account)
                        .padding(.horizontal, 20)
                        .tag(index)
                }
            }
            .frame(height: 160)
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            PageControl(numberOfPages: accounts.count, currentPage: $selectedIndex)
                .frame(height: 8, alignment: .leading)
        }
        .padding(.vertical, 10)
    }
}
