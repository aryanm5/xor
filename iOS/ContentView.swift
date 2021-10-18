//
//  ContentViewIOS.swift
//  CyberCipher
//
//  Created by Aryan Mittal on 10/16/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//


import SwiftUI
import CoreData
import Combine


struct ContentView: View, KeyboardReadable {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    @State private var key: String = "92292"
    @State private var message: String = "Hi, welcome to CyberCipher!"
    @State private var encoded: String = "𖣌𖣭𖢨𖢤𖣳𖣡𖣨𖣧𖣫𖣩𖣡𖢤𖣰𖣫𖢤𖣇𖣽𖣦𖣡𖣶𖣇𖣭𖣴𖣬𖣡𖣶𖢥"
    
    @State private var isKeyboardVisible = false
    
    var body: some View {
        NavigationView {
            ZStack {
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
                            .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                isKeyboardVisible = newIsKeyboardVisible
                            }
                            .onChange(of: key) { newValue in
                                xor()
                            }
                    }
                    
                    Section(header: Text("Message")) {
                        
                        TextEditor(text: $message)
                            .padding(.leading, -5)
                            .onChange(of: message) { newValue in
                                xor()
                            }
                        
                    }
                    
                    Section(header: Text("Cipher")) {
                        Text("\(encoded)")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Section(header: Text("")) {
                        EmptyView()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if isKeyboardVisible {
                            Button("Clear") {
                                clear()
                            }
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        if isKeyboardVisible {
                            Button("Done") {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack(spacing: 20) {
                        
                        BottomButton(action: {
                            swap()
                        }, icon: "arrow.2.squarepath")
                        
                        BottomButton(action: bookmark, icon: items.filter { $0.key == Int64(key) }.isEmpty ? "bookmark" : "bookmark.fill")
                        
                        BottomButton(action: {
                            copy()
                        }, icon: "doc.on.doc")
                        
                        BottomButton(action: {
                            share()
                        }, icon: "square.and.arrow.up")
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Blur(style: .systemThinMaterial))
                    .clipShape(Capsule())
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("CyberCipher")
        }
        .navigationViewStyle(.stack)
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
        
        //encoded = String(utf32CodeUnits: encrypted, count: encrypted.count)
        //encoded = String(bytes: encrypted, encoding: .utf16) ?? "There was an error."
        
        //message = encoded
        //UIPasteboard.general.setValue(encoded, forPasteboardType: "")
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
        UIPasteboard.general.string = encoded
    }
    
    private func share() {
        present(UIActivityViewController(activityItems: [encoded], applicationActivities: nil), animated: true)
    }
    
    private func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        guard var topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { return }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        topController.present(viewController, animated: animated, completion: completion)
    }

    private func bookmark() {
        let filtered = items.filter { $0.key == Int64(key) }
        
        if filtered.isEmpty {
            addItem()
        } else {
            deleteItem(item: filtered[0])
        }
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

    private func deleteItem(item: Item) {
        
        viewContext.delete(item)
            
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

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
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
