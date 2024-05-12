//
//  AddUpdatePantryItem.swift
//  PantryInventoryUsingSwiftDataModelCreation
//
//  Created by Ramill Ibragimov on 5/10/24.
//

import SwiftUI
import SwiftData

struct AddUpdatePantryItem: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var expirationDate: Date = Date()
    
    @State private var selectedPantryItem: PantryItem?
    
    init(item: PantryItem? = nil) {
        if let item {
            _selectedPantryItem = State(initialValue: item)
            _name = State(initialValue: item.name)
            _quantity = State(initialValue: item.quantity)
            _expirationDate = State(initialValue: item.expirationDate ?? Date())
        }
    }
    
    var body: some View {
        Form {
            TextField("Item name", text: $name)
            TextField("Quantity", text: $quantity)
            
            DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
            
            HStack {
                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Cancel")
                }

                Spacer()
                
                Button("Save") {
                    if let selectedPantryItem {
                        selectedPantryItem.name = name
                        selectedPantryItem.quantity = quantity
                        selectedPantryItem.expirationDate = expirationDate
                    } else {
                        let item = PantryItem(name: name, quantity: quantity, expirationDate: expirationDate)
                        
                        modelContext.insert(item)
                    }
                    
                    do {
                        try modelContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle((selectedPantryItem != nil) ? "Update \(name)" : "New Pantry Item")
    }
}

#Preview {
    AddUpdatePantryItem()
}
