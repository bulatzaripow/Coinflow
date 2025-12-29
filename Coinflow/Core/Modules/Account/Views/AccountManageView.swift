//
//  AccountManageView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 28.12.2025.
//

import SwiftUI

struct AccountManageView: View {
    
    // MARK: Props
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AccountManageViewModel
    
    // MARK: UI
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            Form {
                Section {
                    AccountCardView(account: Account(
                        name: viewModel.account?.name ?? viewModel.name,
                        balance: viewModel.account?.balance ?? viewModel.balance,
                        currency: viewModel.account?.currency ?? viewModel.selectedCurrency,
                        sortIndex: 0,
                        isDefault: 1,
                    ))
                }
                
                Section {
                    HStack {
                        TextField("Name", text: $viewModel.name)
                    }
                    
                    HStack {
                        TextField("Balance", value: $viewModel.balance, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Toggle("Default account", isOn: $viewModel.isDefault)
                    }
                    
                    Button {
                        viewModel.path.append(AccountRoutes.currency)
                    } label: {
                        HStack {
                            Image(viewModel.selectedCurrency.code)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.primary)
                            
                            Text(viewModel.selectedCurrency.name)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Text(viewModel.selectedCurrency.code)
                                .foregroundStyle(.tertiary)
                            
                            Image("angle-small-right")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.tertiary)
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: AccountRoutes.self) { route in
                switch route {
                case .account:
                    AccountManageViewBuilder.build(
                        modelContext: modelContext
                    )
                case .currency:
                    SelectCurrencyViewBuilder.build(
                        modelContext: modelContext
                    ) { currency in
                        viewModel.selectedCurrency = currency
                        viewModel.path.removeLast()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("cross")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.red)
                            
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(
                        viewModel.account != nil ?
                        "Edit account" :
                        "Add Account"
                    )
                    .font(.headline)
                    .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.saveAccount(modelContext)
                        dismiss()
                    } label: {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(!viewModel.canSave ? .secondary : .green)
                    }
                    .disabled(!viewModel.canSave)
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
}
