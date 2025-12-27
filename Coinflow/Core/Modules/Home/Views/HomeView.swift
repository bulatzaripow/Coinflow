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
    @Query(sort: \Account.sortIndex) private var accounts: [Account]
    @ObservedObject private var viewModel: HomeViewModel
    @Query private var transactions: [Transaction]
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(.appBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(DateFormatterHelper.formatDayMonth(Date()))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Text("Good Morning, Bulat")
                                    .fontWeight(.bold)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                
                            } label: {
                                Image("user-beard")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 38, height: 38)
                                    .background(.gray.opacity(0.2))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
                        
                        // Accounts
                        AccountCarouselView(accounts: accounts) {
                            // TODO: add account action
                        }
                    }
                    
                    // Transactions
                    TransactionsListView(transactions: transactions)
                        .padding(.bottom, 70)
                }
                
                // Bottom actions
                HStack(spacing: 18) {
                    Button(action: {
                        // TODO: open accounts / wallet
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
                        // TODO: add expense
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
        }
    }
}

#Preview {
    HomeBuilder.build()
}
