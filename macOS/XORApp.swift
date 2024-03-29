//
//  XORApp.swift
//  XOR (macOS)
//
//  Created by Aryan Mittal on 10/16/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//


import SwiftUI

@main
struct XORApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var key: String = "92292"
    @State private var message: String = "Hi, welcome to XOR!"
    @State private var encoded: String = "𖣌𖣭𖢨𖢤𖣳𖣡𖣨𖣧𖣫𖣩𖣡𖢤𖣰𖣫𖢤𖣜𖣋𖣖𖢥"
    
    var body: some Scene {
        WindowGroup {
            ContentView(key: $key, message: $message, encoded: $encoded)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .commands {
            CommandGroup(after: .textEditing) {
                Button(action: swap) {
                    Text("Swap")
                }
                .keyboardShortcut("S")
                
                Button(action: clear) {
                    Text("Clear")
                }
                .keyboardShortcut("D")
                .keyboardShortcut(.clear)
            }
            CommandGroup(after: .pasteboard) {
                Button(action: copy) {
                    Text("Copy Result")
                }
                .keyboardShortcut("C")
            }
        }
    }
    
    
    private func clear() {
        message = ""
        encoded = ""
    }
    
    private func swap() {
        message = encoded
    }
    
    private func copy() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(encoded, forType: .string)
    }
}


extension XORApp {
    
    /// App version.
    static var version: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// App build number.
    static var build: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    /// App's current version and build number.
    static var fullVersion: String? {
        guard let version = version else { return nil }
        guard let build = build else { return version }
        return "\(version) (\(build))"
    }
}

