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
            if let color = account.backgroundColor {
                AppColors(rawValue: color)?.gradient
            }
            
            if let pattern = account.backgroundPattern {
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
            .frame(maxWidth: .infinity, minHeight: 160, alignment: .topLeading)
            .foregroundColor(account.backgroundColor != nil ? .white : .primary)
        }
        .containerRelativeFrame(.horizontal)
        .background(.white)
        .cornerRadius(15)
        .shadow(
            color: Color.gray.opacity(0.4),
            radius: 20,
            y: 5
        )
    }
}
