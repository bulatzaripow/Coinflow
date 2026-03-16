//
//  OverviewView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 11.01.2026.
//

import SwiftUI
import SwiftData

struct OverviewView: View {

    // MARK: - Props

    @ObservedObject var viewModel: OverviewViewModel

    // MARK: - UI

    var body: some View {
        ScrollView {
            HStack {
                Text(viewModel.dateRangeText)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal, 16)

            if !viewModel.expenseCategories.isEmpty {
                OverviewSectionViewBuilder
                    .build(
                        title: "Expenses".localized,
                        totalAmount: viewModel.getTotalAmount(for: .expense),
                        categories: viewModel.expenseCategories,
                        transactions: viewModel.getTransactions(for: .expense),
                        selectedAccount: viewModel.selectedAccount
                    )
            }

            if !viewModel.incomeCategories.isEmpty {
                OverviewSectionViewBuilder
                    .build(
                        title: "Incomes".localized,
                        totalAmount: viewModel.getTotalAmount(for: .income),
                        categories: viewModel.incomeCategories,
                        transactions: viewModel.getTransactions(for: .income),
                        selectedAccount: viewModel.selectedAccount,
                        type: .income
                    )
            }

            if viewModel.expenseCategories.isEmpty && viewModel.incomeCategories.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "chart.bar.xaxis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.secondary)

                    Text("Nothing here yet!")
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text("Add income and expenses to start tracking")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 50)
            }
        }
        .navigationBarTitle("Overview")
        .navigationBarTitleDisplayMode(.large)
        .tint(.primary)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                PopoverMenuButton {
                    Image("calendar-clock")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.primary)
                } content: {
                    DateFilterView(
                        startDate: $viewModel.startDate,
                        endDate: $viewModel.endDate
                    )
                }
            }
        }
    }
}
