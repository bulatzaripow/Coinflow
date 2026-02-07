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
    
    @StateObject var viewModel: AccountManageViewModel
    
    // MARK: UI
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            Form {
                Section {
                    AccountCardView(account: viewModel.accountDraft)
                }
                .listRowInsets(EdgeInsets())
                
                Section {
                    VStack(alignment: .leading, spacing: 4) {

                        TextField("Name", text: $viewModel.accountDraft.name)
                            .autocorrectionDisabled()
                            .onSubmit {
                                UIApplication.shared.sendAction(
                                    #selector(UIResponder.resignFirstResponder),
                                    to: nil,
                                    from: nil,
                                    for: nil
                                )
                            }
                    }
                    .animation(.easeInOut, value: viewModel.nameError)

                    
                    VStack(alignment: .leading, spacing: 4) {

                        TextField("Balance", value: $viewModel.accountDraft.balance, format: .number)
                            .keyboardType(.decimalPad)

                        if let error = viewModel.balanceError {
                            FieldErrorView(message: error.localizedDescription)
                        }
                    }
                    .animation(.easeInOut, value: viewModel.balanceError)

                    
                    HStack {
                        Toggle(
                            "Default account",
                            isOn: $viewModel.accountDraft.isDefault
                        )
                    }
                    
                    Button {
                        viewModel.path.append(AccountRoutes.currency)
                    } label: {
                        HStack {
                            Image(viewModel.accountDraft.currency.code)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.primary)
                            
                            Text(viewModel.accountDraft.currency.name)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Text(viewModel.accountDraft.currency.code)
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
                                AppColors(rawValue: viewModel.accountDraft.backgroundColor ?? "autumn") ?? AppColors.autumn
                            },
                            set: { newValue in
                                viewModel.accountDraft.backgroundColor = newValue?.rawValue
                            }
                        ),
                        action: { color in
                            viewModel.selectColor(color)
                        }
                    )
                    .padding(.vertical, 12)
                    
                    PatternPicker(
                        selectedPattern: $viewModel.accountDraft.backgroundPattern,
                        action: { pattern in
                            viewModel.selectPattern(pattern)
                        }
                    )
                    .padding(.vertical, 12)
                }
                .listRowInsets(EdgeInsets())
                
                // Delete
                Section {
                    Button(role: .destructive) {
                        viewModel.showDeleteAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete account")
                            Spacer()
                        }
                    }
                    .disabled(!viewModel.canDelete)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: AccountRoutes.self) { route in
                switch route {
                case .currency:
                    SelectCurrencyViewBuilder.build(
                        context: modelContext,
                        selectedCurrency: viewModel.accountDraft.currency.code,
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
                        viewModel.account?.modelContext != nil ?
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
            .alert(
                "Delete account?",
                isPresented: $viewModel.showDeleteAlert
            ) {
                
                Button("Cancel", role: .cancel) {}
                
                Button("Delete", role: .destructive) {
                    viewModel.deleteAccount()
                    dismiss()
                }
                
            } message: {
                Text("All transactions will be deleted. Are you sure?")
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
