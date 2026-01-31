//
//  CategoryManageView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import SwiftUI
import SwiftData

struct CategoryManageView: View {
    
    // MARK: - Props
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: CategoryManageViewModel
    
    let onUpdate: () -> Void
    
    // MARK: - UI
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                Form {
                    Section {
                        TextField("Category name", text: $viewModel.name)
                            .font(.system(size: 22))
                        
                        Picker("", selection: $viewModel.type) {
                            Text("Expense").tag(CategoryType.expense)
                            Text("Income").tag(CategoryType.income)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    // Icon Picker
                    Section("Icon") {
                        ForEach(viewModel.icons, id: \.name) { group in
                            VStack(alignment: .leading) {
                                Text(group.name)
                                    .font(.headline)
                                
                                LazyVGrid(columns: viewModel.gridColumns, spacing: 16) {
                                    
                                    ForEach(group.icons, id: \.self) { icon in
                                        
                                        IconItemView(
                                            icon: icon,
                                            isSelected: icon == viewModel.selectedIcon
                                        )
                                        .onTapGesture {
                                            viewModel.selectedIcon = icon
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listRowSpacing(0)
                    .listRowSeparator(.hidden)
                    
                    // Spacer
                    Section {
                        Color.clear
                            .frame(height: 40)
                            .listRowBackground(Color.clear)
                    }
                }
                
                // Save button
                Button {
                    viewModel.saveCategory()
                    onUpdate()
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: 45)
                        .background(viewModel.canSave ? .appPrimary : .secondary.opacity(0.4))
                        .clipShape(Capsule())
                        .shadow(
                            color: Color.black.opacity(0.08),
                            radius: 20,
                            x: 0,
                            y: 10
                        )
                }
                .disabled(!viewModel.canSave)
                .padding(.horizontal, 20)
            }
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
