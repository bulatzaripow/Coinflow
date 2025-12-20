//
//  HomeBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import Foundation

struct HomeBuilder {
    static func build() -> HomeView {
        let viewModel = HomeViewModel()
        let view = HomeView(viewModel: viewModel)
        return view
    }
}
