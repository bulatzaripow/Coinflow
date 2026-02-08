//
//  TransactionsListView.swift
//  Coinflow
//
//  Created by SwiftAI on 18.12.2025.
//

import SwiftUI

struct TransactionsListView: View {
    let selectedAccount: Account?
    let transactions: [Transaction]
    let onTap: (Transaction) -> Void
    let deleteAction: (Transaction) -> Void
    
    var body: some View {
        if !transactions.isEmpty {
            ForEach(transactions) { transaction in
                TransactionRowView(
                    selectedAccount: selectedAccount,
                    transaction: transaction)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            deleteAction(transaction)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    .onTapGesture {
                        onTap(transaction)
                    }
                    .padding(.horizontal, 20)
            }
            
            Color.clear
                .frame(height: 70)
        } else {
            VStack {
                Spacer()
                
                VStack(spacing: 12) {
                    Image(systemName: "list.bullet.clipboard")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("No transactions yet")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    
                    Text("Add your first transaction to see it here")
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}
