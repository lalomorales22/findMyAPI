//
//  FindMyAPIApp.swift
//  FindMyAPI
//
//  Created by brain on 1/3/25.
//

import SwiftUI
import SwiftData

@main
struct FindMyAPIApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(for: Category.self, APIKey.self, configurations: config)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
