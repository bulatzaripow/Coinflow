//
//  AppEntryView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI

struct AppEntryView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        ZStack {
            if hasSeenOnboarding {
                HomeView()
                    .transition(.move(edge: .trailing))
            } else {
                OnboardingView()
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: hasSeenOnboarding)
    }
}

#Preview {
    AppEntryView()
}
