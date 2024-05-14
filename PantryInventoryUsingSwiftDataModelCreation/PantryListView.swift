//
//  PantryListView.swift
//  PantryInventoryUsingSwiftDataModelCreation
//
//  Created by Ramill Ibragimov on 5/11/24.
//

import SwiftUI
import SwiftData

struct PantryListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \PantryItem.expirationDate) private var items: [PantryItem]
    
    @State private var launchInsertNewView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink(value: item) {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.title3.bold())
                            
                            HStack {
                                Text(item.quantity)
                                    
                                Spacer()
                                
                                Text(item.displayExpDate)
                                    .padding(5)
                                    .foregroundColor(.white)
                                    .background(item.displayExpColor, in: .capsule)
                            }
                            .font(.subheadline)
                        }
                    }
                }
                
                HStack {
                    Button {
                        do {
                            try modelContext.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    } label: {
                        Text("Save all changes")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(modelContext.hasChanges == false)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }
            .navigationDestination(for: PantryItem.self) { value in
                AddUpdatePantryItem(item: value)
            }
            .navigationTitle("Pantry Item List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        launchInsertNewView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .sheet(isPresented: $launchInsertNewView) {
                        NavigationStack {
                            AddUpdatePantryItem()
                        }
                        .presentationDetents([.medium])
                    }
                }
            }
        }
    }
}

#Preview {
    PantryListView()
        .modelContainer(PantryItem.mockData)
}
