//
//  SettingsItem.swift
//  CyberCipher
//
//  Created by Aryan Mittal on 10/14/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI

enum SettingsItem: Int {
    
    case saved, rate, share, feedback
    
    var title: LocalizedStringKey {
        switch self {
        case .saved: return "Saved Keys"
        case .rate: return "Rate the App"
        case .share: return "Share"
        case .feedback: return "Feedback"
        }
    }
    
    var subtitle: LocalizedStringKey {
        switch self {
        case .saved: return "Keep track of your favorite keys"
        case .rate: return "Are you loving it?"
        case .share: return "Tell your friends!"
        case .feedback: return "aryan@mittaldev.com"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .saved: return "key"
        case .rate: return "star.fill"
        case .share: return "square.and.arrow.up"
        case .feedback: return "at"
        }
    }
    
    var color: Color {
        switch self {
        case .saved: return .blue
        case .rate: return .pink
        case .share: return .green
        case .feedback: return .blue
        }
    }
    
}
