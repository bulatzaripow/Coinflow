//
//  CategoryListView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 30.01.2026.
//

import SwiftUI

struct CategoryListView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @StateObject var viewModel: CategoryListViewModel
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        VStack {
            Picker("", selection: $viewModel.selectedType) {
                Text("Expense").tag(CategoryType.expense)
                Text("Income").tag(CategoryType.income)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
            .onChange(of: viewModel.selectedType) { _, newValue in
                viewModel.changeType(newValue)
            }
            
            List {
                ForEach(viewModel.categories) { category in
                    CategoryRow(category: category)
                        .onTapGesture {
                            viewModel.onTapAction(category)
                        }
                }
                .onDelete(perform: viewModel.delete)
                .onMove(perform: viewModel.move)
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .animation(.default, value: editMode)
            .toolbar {
                if editMode.isEditing {
                    // Save button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            editMode = .inactive
                        }) {
                            Image("check")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .foregroundColor(.primary)
                                .frame(width: 24, height: 24)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Save")
                    }
                } else {
                    // Edit button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            editMode = .active
                        }) {
                            Image("list")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .foregroundColor(.primary)
                                .frame(width: 24, height: 24)
                        }
                        .accessibilityLabel("Edit")
                    }

                    // Add button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.addNewCategory()
                        }) {
                            Image("plus")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .foregroundColor(.primary)
                                .padding(4)
                                .frame(width: 24, height: 24)
                        }
                        .accessibilityLabel("Add")
                    }
                }
            }
        }
        .navigationTitle("Categories")
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $viewModel.showAddCategorySheet) {
            CategoryManageViewBuilder.build(
                context: modelContext,
                onUpdate: {}
            )
            .presentationDragIndicator(.visible)
        }
        .sheet(item: $viewModel.categoryToEdit) { account in
            if let category = viewModel.categoryToEdit {
                CategoryManageViewBuilder.build(
                    category,
                    context: modelContext,
                    onUpdate: {}
                )
                .presentationDragIndicator(.visible)
            }
        }
    }
}



