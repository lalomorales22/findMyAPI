import SwiftUI

struct AddCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Category Name", text: $name)
            }
            .navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addCategory()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func addCategory() {
        let category = Category(name: name)
        modelContext.insert(category)
        dismiss()
    }
}

// End of file. No additional code.
