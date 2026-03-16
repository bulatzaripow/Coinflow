//
//  OverviewSectionView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 15.01.2026.
//

import SwiftUI

struct OverviewSectionView: View {

    // MARK: - Props

    @ObservedObject var viewModel: OverviewSectionViewModel

    // MARK: - UI

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.primary)

                Spacer()

                Text(CurrencyFormatter.format(
                    viewModel.totalAmount,
                    currency: viewModel.defaultCurrency
                ))
                .fontWeight(.bold)
                .foregroundColor(viewModel.type == .expense ? .appRed : .appGreen)
            }
            .padding(.vertical, 10)

            Divider()

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4),
                spacing: 16
            ) {
                ForEach(viewModel.sortedCategories, id: \.self) { category in
                    VStack {
                        ZStack {
                            Circle()
                                .fill(.appLightGray)
                                .frame(width: 50, height: 50)

                            Image(category.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }

                        Text(CurrencyFormatter.format(
                            viewModel.getTotalAmount(for: category),
                            currency: viewModel.defaultCurrency
                        ))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .font(.system(size: 12, weight: .semibold))

                        Text(category.name)
                            .font(.caption)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}
