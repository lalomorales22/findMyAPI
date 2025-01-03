import SwiftUI

struct AddAPIKeyView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let category: Category?
    
    @State private var name = ""
    @State private var key = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("API Key Name", text: $name)
                SecureField("API Key", text: $key)
                TextField("Description", text: $description)
            }
            .navigationTitle("New API Key")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addAPIKey()
                    }
                    .disabled(name.isEmpty || key.isEmpty)
                }
            }
        }
    }
    
    private func addAPIKey() {
        let apiKey = APIKey(name: name, key: key, description: description)
        if let category = category {
            category.apiKeys.append(apiKey)
            apiKey.category = category
        }
        modelContext.insert(apiKey)
        dismiss()
    }
}
