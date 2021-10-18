//
//  ContentViewMac.swift
//  CyberCipher
//
//  Created by Aryan Mittal on 10/16/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//



import SwiftUI
import CoreData
import Combine


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    @State private var key: String = "92292"
    @State private var message: String = "Hi, welcome to CyberCipher!"
    @State private var encoded: String = "𖣌𖣭𖢨𖢤𖣳𖣡𖣨𖣧𖣫𖣩𖣡𖢤𖣰𖣫𖢤𖣇𖣽𖣦𖣡𖣶𖣇𖣭𖣴𖣬𖣡𖣶𖢥"
    
    var body: some View {
        NavigationView {
            Text("CyberCipher")
            HStack {
                SavedKeysView()
                    .frame(minWidth: 200)
                Form {
                    HStack {
                        Text("Key:")
                        
                        TextField("0", text: $key)
                            .frame(maxWidth: 150)
                            .onReceive(Just(key)) { newValue in
                                var filtered = newValue.filter { Set("0123456789").contains($0) }
                                filtered = String([Int(filtered) ?? 0, 1000000].min()!)
                                if filtered != newValue {
                                    self.key = filtered
                                }
                            }
                            .onChange(of: key) { newValue in
                                xor()
                            }
                    }
                    HStack {
                        
                        VStack {
                            Text("Message:")
                            
                            TextEditor(text: $message)
                                .padding(.leading, -5)
                                .onChange(of: message) { newValue in
                                    xor()
                                }
                        }
                        
                        VStack {
                            Text("Cipher:")
                            Text("\(encoded)")
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                        .frame(minWidth: 150)
                    }
                    .frame(minWidth: 600, minHeight: 200)
                    .padding()
                }
                .navigationTitle("CyberCipher")
                //Spacer()
            }
        }
    }
    
    private func xor() {
        let cipher = UInt32(key)!
        
        var encrypted = [UInt32]()
        
        // encrypt bytes
        for t in message {
            encrypted.append(UInt32(t.unicodeScalarCodePoint()) ^ cipher)//[t.offset % key.count])
        }
        
        let data = Data(bytes: encrypted, count: encrypted.count * MemoryLayout<UInt32>.stride)
        encoded = String(data: data, encoding: .utf32LittleEndian) ?? "That key is not supported! Please try another one."
        
    }
    
    private func clear() {
        message = ""
        encoded = ""
    }
    
    private func swap() {
        let temp = encoded
        encoded = message
        message = temp
    }
    
    
    private func copy() {
        
    }
    
    private func share() {
        
    }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.key = Int64(key)!
            newItem.desc = ""
            
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


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

extension Character {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
