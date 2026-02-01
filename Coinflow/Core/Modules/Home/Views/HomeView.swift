//
//  HomeView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    // MARK: - Props
    
    @Environment(\.modelContext) var modelContext
    @Environment(UserPreferences.self) var userPreferences
    
    @Query(sort: [
        SortDescriptor(\Account.isDefault, order: .reverse),
        SortDescriptor(\Account.sortIndex)
    ])
    private var accounts: [Account]
    
    @ObservedObject private var viewModel: HomeViewModel
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack(alignment: .bottom) {
                Color(.appBackground)
                    .ignoresSafeArea()
                
                List {
                    Section {
                        VStack(spacing: 20) {
                            // Header
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(DateFormatterHelper.formatDayMonth(Date()))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("\(GreetingHelper.greeting())")
                                        .fontWeight(.bold)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                                
                                Button {
                                    viewModel.onNavigate(MainRoutes.settings)
                                } label: {
                                    Image("menu-dots-vertical")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(6)
                                        .frame(width: 35, height: 35)
                                }
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 20)
                            
                            // Accounts
                            AccountCarouselView(
                                accounts: accounts,
                                selectedAccount: $viewModel.selectedAccount
                            ) {
                                viewModel.showAddAccountSheet = true
                            } onTapAccount: { account in
                                viewModel.accountToEdit = account
                            } onSelectAccount: { account in
                                viewModel.setSelectedAccount(account)
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
                    // Transactions
                    Section {
                        TransactionsListView(
                            transactions: viewModel.transactions
                        ) { transaction in
                            viewModel.chooseTransactionToEdit(transaction)
                        } deleteAction: { transaction in
                            viewModel.deleteTransactionAction(transaction)
                        } hideAction: { transaction in
                            viewModel.hideTransactionAction(transaction)
                        }
                    } header: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Recent activity")
                                    .foregroundColor(.primary)
                                Text(viewModel.dateRangeText)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            PopoverMenuButton() {
                                Image("calendar-clock")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.primary)
                            } content: {
                                DateFilterView(
                                    startDate: $viewModel.startDate,
                                    endDate: $viewModel.endDate
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowSpacing(12)
                }
                .listStyle(.plain)
                .listRowSpacing(10)
                .listSectionSpacing(0)
                .scrollContentBackground(.hidden)
                
                
                // Bottom actions
                HStack(spacing: 18) {
                    Button(action: {
                        viewModel.path.append(MainRoutes.overview)
                    }) {
                        Image("chart-simple")
                            .resizable()
                            .scaledToFit()
                            .padding(13)
                            .font(.system(size: 20, weight: .semibold))
                            .frame(width: 45, height: 45)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(
                                color: Color.black.opacity(0.06),
                                radius: 14,
                                x: 0,
                                y: 6
                            )
                    }
                    
                    Button(action: {
                        viewModel.showAddTransactionSheet = true
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "plus")
                                .font(.headline)
                            
                            Text("Add")
                                .font(.headline)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: 45)
                        .background(Color(.appPrimary))
                        .clipShape(Capsule())
                        .shadow(
                            color: Color.black.opacity(0.08),
                            radius: 20,
                            x: 0,
                            y: 10
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .shadow(
                    color: Color.black.opacity(0.08),
                    radius: 20,
                    x: 0,
                    y: 10
                )
            }
            .navigationDestination(for: MainRoutes.self) { route in
                switch route {
                case .overview:
                    OverviewViewBuilder.build(
                        context: modelContext,
                        selectedAccount: viewModel.selectedAccount
                    )
                case .settings:
                    SettingsViewBuilder.build() { route in
                        viewModel.onNavigate(route)
                    }
                case .categories:
                    CategoryListViewBuilder.build(context: modelContext)
                case .currencies:
                    SelectCurrencyViewBuilder.build(
                        context: modelContext,
                        selectedCurrency: userPreferences.defaultCurrencyCode
                    ) { currency in
                        viewModel.setDefaultCurrencyCode(currency.code, userPreferences: userPreferences)
                    }
                }
            }
            .onAppear {
                if viewModel.selectedAccount == nil {
                    viewModel.setSelectedAccount(accounts.first)
                }
            }
            .onChange(of: accounts) { _, newAccounts in
                if viewModel.selectedAccount == nil {
                    viewModel.setSelectedAccount(newAccounts.first)
                }
            }
            .sheet(isPresented: $viewModel.showAddAccountSheet) {
                AccountManageViewBuilder.build(
                    modelContext: modelContext,
                    onAccountAdded: { account in
                        viewModel.setSelectedAccount(account)
                    }
                )
                .presentationDragIndicator(.visible)
            }
            .sheet(item: $viewModel.accountToEdit) { account in
                AccountManageViewBuilder.build(
                    account,
                    modelContext: modelContext,
                    onAccountAdded: { account in
                        viewModel.setSelectedAccount(account)
                    }
                )
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $viewModel.showAddTransactionSheet) {
                if let account = viewModel.selectedAccount {
                    TransactionManageViewBuilder.build(
                        activeAccount: account,
                        context: modelContext,
                        onUpdate: {viewModel.reloadTransactions()},
                    )
                    .presentationDragIndicator(.visible)
                }
            }
            .sheet(item: $viewModel.transactionToEdit) { account in
                if let account = viewModel.selectedAccount {
                    TransactionManageViewBuilder.build(
                        viewModel.transactionToEdit,
                        activeAccount: account,
                        context: modelContext,
                        onUpdate: {viewModel.reloadTransactions()},
                    )
                    .presentationDragIndicator(.visible)
                }
            }
        }
    }
}
