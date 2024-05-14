//
//  PantryInventoryUsingSwiftDataModelCreationApp.swift
//  PantryInventoryUsingSwiftDataModelCreation
//
//  Created by Ramill Ibragimov on 5/10/24.
//

import SwiftUI
import SwiftData

@main
struct PantryInventoryUsingSwiftDataModelCreationApp: App {
    
    @MainActor
    var appContainer: ModelContainer {
        let container = try! ModelContainer(for: Schema([PantryItem.self]))
        container.mainContext.autosaveEnabled = false
        return container
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //.modelContainer(for: PantryItem.self, isAutosaveEnabled: false)
        .modelContainer(appContainer)
    }
}
