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
    
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            TabView {
                
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                    .tabItem {
                        Label("Encryptor", systemImage: "lock.fill")
                    }
                
                
                SettingsView(viewModel: .init())
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
            .sheet(isPresented: $needsAppOnboarding) {
                OnboardingView(isPresented: $needsAppOnboarding)
            }
        }
    }
}


extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false // set to `false` if you don't want to detect tap during other gestures
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
