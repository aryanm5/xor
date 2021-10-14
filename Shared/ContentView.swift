//
//  ContentView.swift
//  Shared
//
//  Created by Aryan Mittal on 10/12/21.
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
    
    
    @State private var key: String = "123"
    @State private var message: String = "abcdefg"
    @State private var encoded: String = "bababab"
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Key", text: $key)
                    .border(Color.green)
                    .keyboardType(.numberPad)
                    .onReceive(Just(key)) { newValue in
                        let filtered = newValue.filter { Set("0123456789").contains($0) }
                        if filtered != newValue {
                            self.key = filtered
                        }
                    }
                Text("Key: \(key)")
                
                TextField("Message", text: $message)
                    .border(Color.green)
                Text("Message: \(message)")
                
                Button("Encode!") {
                    xor()
                }
                
                Text("Encoded: \(encoded)")
                
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
        encoded = String(data: data, encoding: .utf32LittleEndian) ?? "There was an error."
        
        //encoded = String(utf32CodeUnits: encrypted, count: encrypted.count)
        //encoded = String(bytes: encrypted, encoding: .utf16) ?? "There was an error."
        
        message = encoded
        //UIPasteboard.general.setValue(encoded, forPasteboardType: "")
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
