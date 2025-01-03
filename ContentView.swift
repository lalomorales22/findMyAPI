import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    @State private var selectedCategory: Category?
    @State private var isAddingCategory = false
    @State private var isAddingAPIKey = false
    @State private var categoryToEdit: Category? = nil
    @State private var editedCategoryName = ""
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedCategory) {
                NavigationLink("All Categories", value: nil as Category?)
                
                ForEach(categories) { category in
                    NavigationLink(category.name, value: category)
                        .contextMenu {
                            Button(action: {
                                categoryToEdit = category
                                editedCategoryName = category.name
                            }) {
                                Label("Edit Category", systemImage: "pencil")
                            }
                            
                            Button(role: .destructive, action: {
                                deleteCategory(category)
                            }) {
                                Label("Delete Category", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deleteCategory(category)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                categoryToEdit = category
                                editedCategoryName = category.name
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                Button(action: { isAddingCategory.toggle() }) {
                    Label("Add Category", systemImage: "plus")
                }
            }
        } detail: {
            if let selectedCategory = selectedCategory {
                APIKeysView(category: selectedCategory)
                    .toolbar {
                        Button(action: { isAddingAPIKey.toggle() }) {
                            Label("Add API Key", systemImage: "plus")
                        }
                    }
            } else {
                APIKeysView(category: selectedCategory)
                    .toolbar {
                        Button(action: { isAddingAPIKey.toggle() }) {
                            Label("Add API Key", systemImage: "plus")
                        }
                    }
            }
        }
        .sheet(isPresented: $isAddingCategory) {
            AddCategoryView()
        }
        .sheet(isPresented: $isAddingAPIKey) {
            AddAPIKeyView(category: selectedCategory)
        }
        .sheet(item: $categoryToEdit) { category in
            NavigationStack {
                Form {
                    TextField("Category Name", text: $editedCategoryName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }
                .navigationTitle("Edit Category")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            categoryToEdit = nil
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            category.name = editedCategoryName
                            categoryToEdit = nil
                        }
                        .disabled(editedCategoryName.isEmpty)
                    }
                }
            }
            .presentationDetents([.height(200)])
            .presentationDragIndicator(.visible)
        }
    }
    
    private func deleteCategory(_ category: Category) {
        // Remove all API keys in the category
        for apiKey in category.apiKeys {
            modelContext.delete(apiKey)
        }
        // Remove the category itself
        modelContext.delete(category)
        
        // If the deleted category was selected, clear the selection
        if selectedCategory?.id == category.id {
            selectedCategory = nil
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Category.self, inMemory: true)
}

extension Category: Identifiable, Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}
