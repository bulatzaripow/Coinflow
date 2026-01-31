//
//  SettingsView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 09.01.2026.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Props
    
    @ObservedObject private var viewModel: SettingsViewModel
    @Environment(\.modelContext) var modelContext
    @Environment(UserPreferences.self) var userPreferences
    
    // MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        List {
            Section {
                Button {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Label {
                            Text("Language")
                        } icon: {
                            Image("globe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        
                        Spacer()
                        
                        Text(viewModel.currentLanguage)
                            .foregroundColor(.secondary)
                    }
                    .foregroundStyle(Color.primary)
                }
                
                Button {
                    viewModel.goToCurrencies()
                } label: {
                    HStack {
                        Label {
                            Text("Default currency")
                        } icon: {
                            Image("coins")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        
                        Spacer()
                        
                        Text(userPreferences.defaultCurrencyCode)
                            .foregroundColor(.secondary)
                    }
                    .foregroundStyle(Color.primary)
                }
                
                Button {
                    viewModel.goToCategories()
                } label: {
                    HStack {
                        Label {
                            Text("Categories")
                        } icon: {
                            Image("apps")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                    }
                    .foregroundStyle(Color.primary)
                }
            }
            
            Section {
                NavigationLink {
                    AttributionView()
                } label: {
                    Label {
                        Text("Attribution")
                    } icon: {
                        Image("info")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.primary)
                    }
                }
                
                Button {
                    viewModel.showPrivacyPolicy = true
                } label: {
                    Label {
                        Text("Privacy policy")
                    } icon: {
                        Image("user-lock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    .foregroundStyle(Color.primary)
                }
                
                Button {
                    viewModel.showTermsOfService = true
                } label: {
                    Label {
                        Text("Terms of service")
                    } icon: {
                        Image("terms-check")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    .foregroundStyle(Color.primary)
                }
            } footer: {
                VStack {
                    HStack(alignment: .center) {
                        Text("Made with")
                        Image("heart-tat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        Text("in Tatarstan")
                    }
                    .font(.caption)
                    
                    HStack(alignment: .center) {
                        Text("Version \(viewModel.version)")
                        Button {
                            if let url = URL(string: "https://github.com/bulatzaripow/Coinflow") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image("github")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.plain)
                    }
                    .font(.caption)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            if let url = viewModel.privacyPolicyURL {
                SafariView(url: url)
                    .edgesIgnoringSafeArea(.all)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
        .sheet(isPresented: $viewModel.showTermsOfService) {
            if let url = viewModel.termsURL {
                SafariView(url: url)
                    .edgesIgnoringSafeArea(.all)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
