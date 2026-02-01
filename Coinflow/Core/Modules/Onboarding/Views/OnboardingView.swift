//
//  OnboardingView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(UserPreferences.self) var userPreferences
        
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.init(hex: "#136a8a"), .init(hex: "#267871")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "banknote.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                
                VStack(spacing: 10) {
                    Text("Coinflow")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Take control of your finances")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal)
                }
                
                Button(action: {
                    userPreferences.setHasSeenOnboarding(true)
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(Color(.appPrimary))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .cornerRadius(25)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}
