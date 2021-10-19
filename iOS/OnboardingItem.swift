//
//  OnboardingItem.swift
//  CyberCipher (iOS)
//
//  Created by Aryan Mittal on 10/18/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI
import Foundation

enum OnboardingItem: Int {
    case secure, twoway, save
    
    var title: String {
        switch self {
        case .secure: return "Secure Encryption"
        case .twoway: return "Bidirectional Cipher"
        case .save: return "Bookmarkable Keys"
        }
    }
    
    var subtitle: String {
        switch self {
        case .secure: return "Choose a secret key to protect your messages."
        case .twoway: return "Paste encrypted text back into the message box to decrypt!"
        case .save: return "Save your favorite keys to always know the best options."
        }
    }
    
    var systemImageName: String {
        switch self {
        case .secure: return "key.fill"
        case .twoway: return "arrow.left.and.right"
        case .save: return "bookmark.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .secure: return .blue
        case .twoway: return .pink
        case .save: return .green
        }
    }
}
