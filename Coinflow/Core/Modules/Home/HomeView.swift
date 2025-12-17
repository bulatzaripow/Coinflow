//
//  HomeView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        Button(action: {
            hasSeenOnboarding = false
        }) {
            Text("Back to onboarding")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.init(hex: "#267871"))
                .cornerRadius(25)
                .padding(.horizontal, 40)
        }
    }
}

#Preview {
    HomeView()
}
