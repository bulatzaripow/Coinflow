//
//  SelectCurrencyView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 29.12.2025.
//

import SwiftUI
import SwiftData

struct SelectCurrencyView: View {

    // MARK: - Props

    @ObservedObject var viewModel: SelectCurrencyViewModel

    @Query(sort: \Currency.sortIndex) var currencies: [Currency]

    private var filteredCurrencies: [Currency] {
        return viewModel.searchCurrencies(currencies)
    }

    // MARK: - UI

    var body: some View {
        VStack {
            List {
                ForEach(filteredCurrencies) { currency in
                    Button {
                        viewModel.selectCurrency(currency)
                    } label: {
                        HStack {
                            Image(currency.code)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .clipShape(Circle())

                            VStack(alignment: .leading) {
                                HStack {
                                    Text(currency.code)
                                    Text(currency.symbol)
                                        .foregroundColor(.secondary)
                                }

                                Text(currency.name)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            if viewModel.isSelected(currency) {
                                Image("check")
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
