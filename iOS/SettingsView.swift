//
//  SettingsViewIOS.swift
//  XOR
//
//  Created by Aryan Mittal on 10/16/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.topItems, id: \.rawValue) { item in
                        NavigationLink {
                            SavedKeysView()
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        } label: {
                            SettingsRow(item: item)
                        }
                    }
                }
                
                Section(footer: footer) {
                    /*ForEach(viewModel.footerItems, id: \.rawValue) { item in
                     Button(action: { handleTapOnItem(item) }) {
                     SettingsRow(item: item)
                     }
                     }*/
                    
                    Button(action: { handleTapOnItem(.rate) }) {
                        SettingsRow(item: .rate)
                    }
                    
                    ShareLink(item: viewModel.shareURL) {
                        SettingsRow(item: .share)
                    }
                    
                    Button(action: { handleTapOnItem(.feedback) }) {
                        SettingsRow(item: .feedback)
                    }
                    
                    NavigationLink {
                        AboutView()
                    } label: {
                        SettingsRow(item: viewModel.lastItem)
                    }
                    
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Settings")
        }
        .navigationViewStyle(.stack)
    }
    
    var footer: some View {
        XORApp.fullVersion
            .map { Text("VERSION \($0)") }
            .textCase(.uppercase)
            .foregroundColor(.secondary)
            .font(.caption2)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowInsets(EdgeInsets(top: 24.0, leading: 0.0, bottom: 24.0, trailing: 0.0))
    }
    
    private func handleTapOnItem(_ item: SettingsItem) {
        switch item {
        case .saved:
            break
        case .rate:
            openURL(viewModel.rateURL)
        case .share:
            present(UIActivityViewController(activityItems: [viewModel.shareURL], applicationActivities: nil), animated: true)
        case .feedback:
            openURL(viewModel.feedbackURL)
        case .about:
            break
        }
    }
    
    private func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
    private func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        guard var topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { return }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        topController.present(viewController, animated: animated, completion: completion)
    }
    
    
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .init())
    }
}
