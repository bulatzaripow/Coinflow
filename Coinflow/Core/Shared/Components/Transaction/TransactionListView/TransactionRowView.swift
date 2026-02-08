//
//  TransactionRowView.swift
//  Coinflow
//
//  Created by SwiftAI on 18.12.2025.
//

import SwiftUI

struct TransactionRowView: View {
    let selectedAccount: Account?
    let transaction: Transaction
    
    // MARK: - Private
    
    private var isIncome: Bool {
        if transaction.type == .transfer {
            return transaction.toAccount?.id == selectedAccount?.id
        }
        
        return transaction.type == .income
    }
    
    private var amountText: String {
        let sign = isIncome ? "+" : ""
        return sign + (transaction.amount as NSNumber).stringValue
    }
    
    private var amountColor: Color {
        isIncome ? Color.green : Color.red
    }
    
    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: transaction.date)
    }
    
    private var transactionText: String {
        guard transaction.type != .transfer else {
            return "Transfer"
        }
        
        return transaction.category?.name ?? "Other"
    }
    
    private var transactionIcon: Image {
        guard transaction.type != .transfer else {
            return Image("send-dollars")
        }
        
        return Image(transaction.category?.icon ?? "questionmark")
    }
    
    // MARK: - UI
    
    var body: some View {
        HStack(spacing: 10) {
            // Icon
            ZStack {
                Circle()
                    .fill(
                        Color(.systemGray6)
                    )
                transactionIcon
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .font(.system(size: 18))
            }
            .frame(width: 40, height: 40)
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(transactionText)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                if  transaction.type == .transfer,
                    let from = transaction.account,
                    let to = transaction.toAccount {
                    Text("\(from.name) > \(to.name)")
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Text(dateText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Amount
            Text(transaction.formattedData())
                .font(.headline)
                .fixedSize(horizontal: true, vertical: false)
                .foregroundStyle(amountColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(15)
        .clipped()
        .shadow(
            color: Color.black.opacity(0.03),
            radius: 18,
            x: 0,
            y: 8
        )
    }
}
