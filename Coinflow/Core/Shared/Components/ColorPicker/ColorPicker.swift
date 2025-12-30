//
//  ColorPicker.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.12.2025.
//

import Foundation
import SwiftUI

struct ColorPicker: View {
    
    // MARK: Props
    
    @Binding var selectedColor: AppColors?
    var action: (AppColors?) -> Void
    
    // MARK: UI
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button {
                    selectedColor = nil
                    action(nil)
                } label: {
                    ZStack {
                        Circle()
                            .stroke(
                                selectedColor == nil ? Color.blue : Color.gray.opacity(0.3),
                                lineWidth: 2
                            )
                            .frame(width: 36, height: 36)
                        
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 28, height: 28)
                        
                        Image(systemName: "circle.slash")
                            .font(.system(size: 12))
                            .foregroundColor(selectedColor == nil ? .blue : .gray)
                    }
                }
                .padding(.leading, 14)
                
                ForEach(AppColors.allCases) { color in
                    Button {
                        selectedColor = color
                        action(color)
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(
                                    selectedColor == color ? Color.blue : Color.gray.opacity(0.3),
                                    lineWidth: 2
                                )
                                .frame(width: 36, height: 36)
                            
                            Circle()
                                .fill(color.gradient)
                                .frame(width: 28, height: 28)
                        }
                    }
                }
            }
            .padding(.vertical, 2)
        }
    }
}
