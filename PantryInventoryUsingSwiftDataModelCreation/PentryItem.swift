//
//  PentryItem.swift
//  PantryInventoryUsingSwiftDataModelCreation
//
//  Created by Ramill Ibragimov on 5/10/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class PentryItem {
    var name: String
    var quantity: String
    var expirationDate: Date?
    
    init(name: String, quantity: String, expirationDate: Date? = nil) {
        self.name = name
        self.quantity = quantity
        self.expirationDate = expirationDate
    }
}

extension PentryItem {
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
