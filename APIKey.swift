import Foundation
import SwiftData

@Model
class APIKey {
    // Your properties
    var name: String
    var key: String
    var apiDescription: String
    var dateAdded: Date
    var category: Category?
    
    init(name: String, key: String, description: String) {
        self.name = name
        self.key = key
        self.apiDescription = description
        self.dateAdded = Date()
    }
    
    var exportString: String {
        "export \(name)=\(key)"
    }
}

// Make APIKey identifiable for SwiftUI
extension APIKey: Identifiable {}

// End of file. No additional code.
