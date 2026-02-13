//
//  OverviewSectionViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 15.01.2026.
//

import Foundation

struct OverviewSectionViewBuilder {
    static func build(
        title: String,
        totalAmount: Double,
        categories: [Category],
        transactions: [Transaction],
        selectedAccount: Account? = nil,
        type: OverviewSectionViewType = .expense
    ) -> OverviewSectionView {

        let viewModel = OverviewSectionViewModel(
            title: title,
            totalAmount: totalAmount,
            categories: categories,
            transactions: transactions,
            selectedAccount: selectedAccount,
            type: type
        )

        return OverviewSectionView(viewModel: viewModel)
    }
}

enum OverviewSectionViewType {
    case expense
    case income
}
