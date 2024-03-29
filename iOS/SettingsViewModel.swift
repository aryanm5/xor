//
//  SettingsViewModel.swift
//  XOR
//
//  Created by Aryan Mittal on 10/14/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    @Published private(set) var topItems: [SettingsItem] = [.saved]
    @Published private(set) var footerItems: [SettingsItem] = [.rate, .share, .feedback]
    @Published private(set) var lastItem: SettingsItem = .about
    
    
    var rateURL: URL {
        URL(string: "itms-apps://apps.apple.com/app/id1590957645?action=write-review")!
    }
    
    var shareURL: URL {
        URL(string: "https://apps.apple.com/app/id1590957645")!
    }
    
    var feedbackURL: URL {
        URL(string: "mailto:aryan@mittaldev.com")!
    }
    
    
}
