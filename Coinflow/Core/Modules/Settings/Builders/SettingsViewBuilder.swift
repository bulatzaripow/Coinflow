//
//  SettingsViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 09.01.2026.
//

import SwiftUI

struct SettingsViewBuilder {
    static func build(
        onNavigate: @escaping (MainRoutes) -> Void
    ) -> SettingsView {
        let viewModel = SettingsViewModel(onNavigate: onNavigate)

        return SettingsView(
            viewModel: viewModel
        )
    }
}
