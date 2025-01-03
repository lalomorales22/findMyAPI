import Foundation
import SwiftData

@Model
final class Category {
    var id: String
    var name: String
    @Relationship(deleteRule: .cascade) var apiKeys: [APIKey]
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.apiKeys = []
    }
}

