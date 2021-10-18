//
//  SavedKeysView.swift
//  CyberCipher
//
//  Created by Aryan Mittal on 10/14/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI
import CoreData

struct SavedKeysView: View {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        
        if items.isEmpty {
            HStack(alignment: .center) {
                VStack(alignment: .center, spacing: 6.0) {
                    
                    Text("No saved keys")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("Tap the bookmark icon to\nsave your favorite keys")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(EdgeInsets(top: 0.0, leading: 44.0, bottom: 0.0, trailing: 44.0))
            }
            .navigationTitle("Saved Keys")
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        } else {
            List {
                ForEach(items) { item in
                    NavigationLink(destination:
                                    KeyDetails(item: item, key: String(item.key), desc: item.desc ?? "")
                                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                                   
                    ) {
                        VStack(alignment: .leading, spacing: 3.0) {
                            Text(String(item.key))
                                .font(.body)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            if item.desc != nil && item.desc != "" {
                                Text(item.desc ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
#if !os(macOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
            }
            .navigationTitle("Saved Keys")
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
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

struct SavedKeysView_Previews: PreviewProvider {
    static var previews: some View {
        SavedKeysView()
    }
}
