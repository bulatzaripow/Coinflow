//
//  AddAccountCardView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 27.12.2025.
//

import SwiftUI

struct AddAccountCardView: View {
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)

                Text("Add account")
                    .font(.headline)
            }
            .frame(minHeight: 160)
            .containerRelativeFrame(.horizontal)
            .foregroundColor(.appPrimary)
            .background(.white)
            .cornerRadius(15)
            .shadow(
                color: Color.gray.opacity(0.3),
                radius: 10,
                y: 5
            )
        }
    }
}
