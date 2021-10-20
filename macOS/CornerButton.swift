//
//  CornerButtons.swift
//  XOR (macOS)
//
//  Created by Aryan Mittal on 10/17/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI

struct CornerButton: View {
    let action: () -> Void
    let icon: String
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(Font.body.weight(.bold))
        }
    }
}

struct CornerButton_Previews: PreviewProvider {
    static var previews: some View {
        CornerButton(action: {}, icon: "gearshape")
    }
}
