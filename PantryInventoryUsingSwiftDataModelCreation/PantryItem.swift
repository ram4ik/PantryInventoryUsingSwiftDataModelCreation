//
//  PantryItem.swift
//  PantryInventoryUsingSwiftDataModelCreation
//
//  Created by Ramill Ibragimov on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class PantryItem {
    var name: String
    var quantity: String
    var expirationDate: Date?
    
    init(name: String, quantity: String, expirationDate: Date? = nil) {
        self.name = name
        self.quantity = quantity
        self.expirationDate = expirationDate
    }
}

extension PantryItem {
    var displayExpDate: String {
        guard let expDate = expirationDate else {
            return ""
        }
        
        if expDate <= Date() {
            return "Expired on " + expDate.formatted(date: .numeric, time: .omitted)
        } else if expDate > Date() {
            return "Will expired on " + expDate.formatted(date: .numeric, time: .omitted)
        }
        
        return ""
    }
    
    var displayExpColor: Color {
        guard let expDate = expirationDate else {
            return Color.clear
        }
        
        if expDate <= Date() {
            return .pink
        } else if expDate > Date() {
            return .mint
        }
        
        return .clear
    }
}

extension PantryItem {
    @MainActor
    static var mockData: ModelContainer {
        let container = try! ModelContainer(for: PantryItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        container.mainContext.insert(PantryItem(name: "Pasta", quantity: "1 lbs", expirationDate: dateFormatter.date(from: "05/01/24")))
        
        container.mainContext.insert(PantryItem(name: "Olive Oil", quantity: "200 oz", expirationDate: dateFormatter.date(from: "05/01/24")))
        
        container.mainContext.insert(PantryItem(name: "Snacks", quantity: "1 pack", expirationDate: dateFormatter.date(from: "06/01/24")))
        
        return container
    }
}
