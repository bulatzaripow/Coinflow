//
//  AttributionView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 11.01.2026.
//

import SwiftUI

struct AttributionView: View {

    // MARK: - Props

    @State private var showSafariForIconsLink = false
    @State private var showSafariForFlagsLink = false

    private let linkIconsURL = URL(string: "https://www.flaticon.com/uicons/interface-icons")
    private let linkFlagsURL = URL(string: "https://www.flaticon.com/packs/countrys-flags")

    // MARK: - UI

    var body: some View {
        List {
            Section {
                Button {
                    showSafariForIconsLink = true
                } label: {
                    HStack {
                        Label {
                            Text("Interface icons")
                                .foregroundColor(.primary)
                        } icon: {
                            Image("flaticon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }

                        Spacer()

                        Image("angle-small-right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }

                Button {
                    showSafariForFlagsLink = true
                } label: {
                    HStack {
                        Label {
                            Text("Flags")
                                .foregroundColor(.primary)
                        } icon: {
                            Image("USD")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.primary)
                        }

                        Spacer()

                        Image("angle-small-right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Attribution")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSafariForIconsLink) {
            if let url = linkIconsURL {
                SafariView(url: url)
                    .edgesIgnoringSafeArea(.all)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
        .sheet(isPresented: $showSafariForFlagsLink) {
            if let url = linkFlagsURL {
                SafariView(url: url)
                    .edgesIgnoringSafeArea(.all)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
