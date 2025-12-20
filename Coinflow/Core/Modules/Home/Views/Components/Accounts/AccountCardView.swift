//
//  AccountCardView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI

struct AccountCardView: View {
    let account: Account
    
    var body: some View {
        ZStack {
            if let pattern = account.accountPattern {
                Image(pattern)
                    .resizable(resizingMode: .tile)
                    .renderingMode(.template)
                    .foregroundColor(.appPrimary.opacity(0.1))
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Total Balance")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(account.name)
                            .font(.headline)
                        
                        Text(String(account.formattedBalance()))
                            .font(.system(size: 28, weight: .bold))
                    }
                    
                    Spacer()
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, minHeight: 140, alignment: .topLeading)
        }
        .background(.white)
        .cornerRadius(30)
        .shadow(
            color: Color.gray.opacity(0.1),
            radius: 30,
            y: 5
        )
    }
}
