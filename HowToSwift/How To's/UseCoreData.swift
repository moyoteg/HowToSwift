//
//  UseCoreData.swift
//  HowToSwift
//
//  Created by Moi Gutierrez on 2/22/21.
//

import SwiftUI

struct UserCoreData: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            
            Group {
                if items.isEmpty {
                    Text("no items")
                } else {
                    List {
                        ForEach(items) { item in
                            NavigationLink("Item at \(item.timestamp!, formatter: ItemView.itemFormatter)", destination:
                                            ItemView(item: item)
                            )
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .toolbar {
                HStack {
                    #if os(iOS)
                    EditButton()
                    #endif
                    
                    Spacer()
                    
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ItemView: View {
    
    @ObservedObject var item: Item
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            if item.timestamp != nil {
                Text("Item at \(item.timestamp!, formatter: ItemView.itemFormatter)")
                Button("update timestamp") {
                    
                    item.timestamp = Date()
                    try? viewContext.save()
                }
            } else {
                Text("no timestamp")
            }
        }
    }
    
    static let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}
