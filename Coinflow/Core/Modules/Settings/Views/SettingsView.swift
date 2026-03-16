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
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.primary)
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
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.primary)
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
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.primary)
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
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.primary)
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
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.primary)
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
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.primary)
                    }
                    .foregroundStyle(Color.primary)
                }
            } footer: {
                VStack {
                    HStack {
                        Button {
                            if let url = URL(string: "https://github.com/bulatzaripow/Coinflow") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image("github")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(.plain)
                    }
                    VStack(spacing: 4) {
                        Text("Created by Bulat Zaripov")

                        Text("Version \(viewModel.version)")
                    }
                    .font(.caption2)
                    .foregroundColor(.secondary)
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
