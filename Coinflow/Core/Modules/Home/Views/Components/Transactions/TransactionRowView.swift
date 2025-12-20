//
//  TransactionRowView.swift
//  Coinflow
//
//  Created by SwiftAI on 18.12.2025.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    
    // MARK: - Private
    
    private var isIncome: Bool {
        transaction.type == .income || transaction.amount > 0
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
    
    // MARK: - UI
    
    var body: some View {
        HStack(spacing: 10) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.15))
                Image(systemName: "cup.and.saucer.fill")
                    .foregroundStyle(.orange)
                    .font(.system(size: 18))
            }
            .frame(width: 40, height: 40)
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                if let note = transaction.note {
                    Text(note)
                        .font(.caption)
                        .lineLimit(2)
                        .truncationMode(.tail)
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
        .cornerRadius(26)
        .clipped()
        .shadow(
            color: Color.black.opacity(0.03),
            radius: 18,
            x: 0,
            y: 8
        )
    }
}

#Preview {
    TransactionRowView(transaction: Transaction.demoTransactions.first!)
        .padding()
        .background(Color(hex: "#F6F7F8"))
}


