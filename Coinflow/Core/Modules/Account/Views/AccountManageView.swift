//
//  AccountManageView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 28.12.2025.
//

import SwiftUI
import SwiftData

struct AccountManageView: View {
    
    // MARK: Props
    
    @Environment(\.modelContext) var modelContext
    @Environment(UserPreferences.self) var userPreferences
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AccountManageViewModel
    
    // MARK: UI
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            Form {
                Section {
                    AccountCardView(account: viewModel.account)
                }
                .listRowInsets(EdgeInsets())
                
                Section {
                    VStack(alignment: .leading, spacing: 4) {

                        TextField("Name", text: $viewModel.account.name)

                        if let error = viewModel.nameError {
                            FieldErrorView(message: error.localizedDescription)
                        }
                    }
                    .animation(.easeInOut, value: viewModel.nameError)

                    
                    VStack(alignment: .leading, spacing: 4) {

                        TextField("Balance", value: $viewModel.account.balance, format: .number)
                            .keyboardType(.decimalPad)

                        if let error = viewModel.balanceError {
                            FieldErrorView(message: error.localizedDescription)
                        }
                    }
                    .animation(.easeInOut, value: viewModel.balanceError)

                    
                    HStack {
                        Toggle(
                            "Default account",
                            isOn: Binding(
                                get: {
                                    viewModel.account.isDefault == 1
                                },
                                set: { newValue in
                                    viewModel.account.isDefault = newValue ? 1 : 0
                                }
                            )
                        )
                    }
                    
                    Button {
                        viewModel.path.append(AccountRoutes.currency)
                    } label: {
                        HStack {
                            Image(viewModel.account.currency.code)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.primary)
                            
                            Text(viewModel.account.currency.name)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Text(viewModel.account.currency.code)
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
                
                Section("Design") {
                    ColorPicker(
                        selectedColor: Binding(
                            get: {
                                AppColors(rawValue: viewModel.account.backgroundColor ?? "autumn") ?? AppColors.autumn
                            },
                            set: { newValue in
                                viewModel.account.backgroundColor = newValue?.rawValue
                            }
                        ),
                        action: { color in
                            viewModel.selectColor(color)
                        }
                    )
                    .padding(.vertical, 12)
                    
                    PatternPicker(
                        selectedPattern: $viewModel.account.backgroundPattern,
                        action: { pattern in
                            viewModel.selectPattern(pattern)
                        }
                    )
                    .padding(.vertical, 12)
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: AccountRoutes.self) { route in
                switch route {
                case .currency:
                    SelectCurrencyViewBuilder.build(
                        context: modelContext,
                        selectedCurrency: userPreferences.defaultCurrencyCode,
                    ) { currency in
                        viewModel.selectCurrency(currency)
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
                        viewModel.account.modelContext != nil ?
                        "Edit account" :
                        "Add Account"
                    )
                    .font(.headline)
                    .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.saveAccount()
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

struct FieldErrorView: View {

    let message: String

    var body: some View {
        Text(message)
            .font(.caption)
            .foregroundColor(.red)
            .padding(.top, 2)
            .transition(.opacity.combined(with: .move(edge: .top)))
    }
}
