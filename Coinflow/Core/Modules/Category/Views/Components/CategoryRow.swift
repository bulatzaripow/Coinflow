//
//  CategoryRow.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import SwiftUI

struct CategoryRow: View {
    
    let category: Category
    
    var body: some View {
        HStack(spacing: 14) {
            
            // Icon
            Image(category.icon)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(.primary)
                .frame(width: 36, height: 36)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            // Name
            Text(category.name)
                .font(.system(size: 16, weight: .medium))
            
            
            Spacer()
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
    }
}
