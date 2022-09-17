//
//  KeyDetails.swift
//  XOR (iOS
//
//  Created by Aryan Mittal on 10/17/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI
import Combine

struct KeyDetails: View, KeyboardReadable {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let item: Item
    @State var key: String
    @State var desc: String
    @State private var isKeyboardVisible: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Key")) {
                TextField("0", text: $key)
                    .keyboardType(.numberPad)
                    .onReceive(Just(key)) { newValue in
                        var filtered = newValue.filter { Set("0123456789").contains($0) }
                        filtered = String([Int(filtered) ?? 0, 1000000].min()!)
                        if filtered != newValue {
                            self.key = filtered
                        }
                    }
                    .onChange(of: key) { _ in
                        saveKey()
                    }
                    .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                        isKeyboardVisible = newIsKeyboardVisible
                    }
            }
            
            Section(header: Text("Description")) {
                TextEditor(text: $desc)
                    .padding(.leading, -5)
                    .onChange(of: desc) { _ in
                        saveDesc()
                    }
                    .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                        isKeyboardVisible = newIsKeyboardVisible
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isKeyboardVisible {
                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
        }
        .navigationTitle("Key \(key)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveKey() {
        item.key = Int64(key)!
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    private func saveDesc() {
        
        item.desc = desc
        
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

/*struct KeyDetails_Previews: PreviewProvider {
 
 static var previews: some View {
 KeyDetails()
 }
 }*/
