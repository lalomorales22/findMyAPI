import SwiftUI
import SwiftData

struct APIKeysView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allAPIKeys: [APIKey]
    let category: Category?
    @State private var searchText = ""

    var filteredKeys: [APIKey] {
        let categoryKeys = category?.apiKeys ?? allAPIKeys
        if searchText.isEmpty {
            return categoryKeys
        }
        return categoryKeys.filter { apiKey in
            apiKey.name.localizedCaseInsensitiveContains(searchText) ||
            apiKey.apiDescription.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        List(filteredKeys) { apiKey in
            APIKeyRow(apiKey: apiKey)
        }
        .searchable(text: $searchText, prompt: "Search API Keys")
        .navigationTitle(category?.name ?? "All API Keys")
    }
}

struct APIKeyRow: View {
    @Environment(\.modelContext) private var modelContext
    let apiKey: APIKey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(apiKey.name)
                    .font(.headline)
                
                Spacer()
                
                Button(action: { deleteAPIKey() }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            
            SecureField("", text: .constant(apiKey.key))
                .textFieldStyle(.plain)
            
            Text(apiKey.apiDescription)
                .foregroundColor(.secondary)
            
            HStack {
                Button(action: { copyKey() }) {
                    Label("Copy Key", systemImage: "doc.on.doc")
                }
                
                Button(action: { copyExport() }) {
                    Label("Copy as Export", systemImage: "terminal")
                }
            }
            
            Text("Added \(apiKey.dateAdded.formatted())")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
    
    private func copyKey() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(apiKey.key, forType: .string)
    }
    
    private func copyExport() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(apiKey.exportString, forType: .string)
    }
    
    private func deleteAPIKey() {
        modelContext.delete(apiKey)
    }
}
