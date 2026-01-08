//
//  TransactionManageView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 05.01.2026.
//

import SwiftUI
import SwiftData

struct TransactionManageView: View {
    
    // MARK: Props
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: TransactionManageViewModel
    
    // MARK: Init
    
    init(viewModel: TransactionManageViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: UI
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Form {
                    Section {
                        TextField(CurrencyFormatter.format(0, currency: viewModel.activeAccount.currency), text: $viewModel.amount)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 44))
                            .multilineTextAlignment(.center)
                        
                        Picker("", selection: $viewModel.type) {
                            Text("Expense").tag(TransactionType.expense)
                            Text("Income").tag(TransactionType.income)
                            Text("Transfer").tag(TransactionType.transfer)
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: viewModel.type) { _, _ in
                            viewModel.updateSelectedCategory()
                        }
                    }
                    
                    Section {
                        HorizontalItemPicker(
                            items: viewModel.accounts,
                            selectedItem: viewModel.selectedAccount,
                            title: viewModel.type == .transfer ? "From account" : "Account",
                            icon: { Image($0.icon) },
                            text: { $0.name }
                        ) { account in
                            viewModel.selectedAccount = account
                        }
                        .padding(.top, 16)
                        
                        if viewModel.type == .transfer {
                            HorizontalItemPicker(
                                items: viewModel.accounts,
                                selectedItem: viewModel.selectedToAccount,
                                title: "To account",
                                icon: { Image($0.icon) },
                                text: { $0.name }
                            ) { account in
                                viewModel.selectedToAccount = account
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 16)
                        } else {
                            HorizontalItemPicker(
                                items: viewModel.filteredCategories,
                                selectedItem: viewModel.selectedCategory,
                                title: "Category",
                                icon: { Image($0.icon) },
                                text: { $0.name }
                            ) { category in
                                viewModel.selectedCategory = category
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 16)
                        }
                        
                    }
                    .listRowInsets(EdgeInsets())
                    
                    Section {
                        DatePicker(
                            "Date",
                            selection: $viewModel.date,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        
                        ZStack(alignment: .leading) {
                            if viewModel.note.isEmpty {
                                Text("Note")
                                    .padding(.leading, 8)
                                    .foregroundColor(.gray)
                            }

                            TextEditor(text: $viewModel.note)
                        }
                    }
                    
                    Section {
                        Color.clear
                            .frame(height: 30)
                            .listRowBackground(Color.clear)
                    }
                }
                
                Button(action: {
                    viewModel.saveTransaction()
                    dismiss()
                }) {
                    Text("Save")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background(viewModel.canModify ? .appPrimary : .secondary.opacity(0.4))
                    .clipShape(Capsule())
                    .shadow(
                        color: Color.black.opacity(0.08),
                        radius: 20,
                        x: 0,
                        y: 10
                    )
                }
                .disabled(!viewModel.canModify)
                .padding(.horizontal, 20)
            }
        }
    }
}
