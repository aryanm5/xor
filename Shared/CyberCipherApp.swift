//
//  CyberCipherApp.swift
//  Shared
//
//  Created by Aryan Mittal on 10/12/21.
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
