//
//  CyberCipherApp.swift
//  CyberCipher (macOS)
//
//  Created by Aryan Mittal on 10/16/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//


import SwiftUI

@main
struct CyberCipherApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


extension CyberCipherApp {
    
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

