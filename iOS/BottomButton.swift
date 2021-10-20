//
//  BottomButton.swift
//  XOR
//
//  Created by Aryan Mittal on 10/14/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI

struct BottomButton: View {
    let action: () -> Void
    let icon: String
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(Font.title2.weight(.bold))
        }
        .padding(10)
    }
}

struct BottomButton_Previews: PreviewProvider {
    static var previews: some View {
        BottomButton(action: {}, icon: "gearshape")
    }
}
