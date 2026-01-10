//
//  SettingsViewBuilder.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 09.01.2026.
//

import Foundation

struct SettingsViewBuilder {
    static func build() -> SettingsView {
        let vm = SettingsViewModel()
        
        return SettingsView(
            viewModel: vm
        )
    }
}
