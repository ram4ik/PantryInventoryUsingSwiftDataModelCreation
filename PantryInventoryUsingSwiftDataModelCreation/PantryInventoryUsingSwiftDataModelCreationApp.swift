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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PantryItem.self, isAutosaveEnabled: false)
    }
}
