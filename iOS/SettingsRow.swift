//
//  SettingsRow.swift
//  XOR
//
//  Created by Aryan Mittal on 10/14/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI

struct SettingsRow: View {
    
    let item: SettingsItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            Image(systemName: item.systemImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22.0, height: 22.0)
                .padding(3.0)
                //.background(item.color)
                //.foregroundColor(.white)
                .foregroundColor(item.color)
                //.font(.largeTitle)
                //.clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
                .font(Font.largeTitle.weight(.medium))
            
            VStack(alignment: .leading, spacing: 3.0) {
                Text(item.title)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(item.subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 5.0)
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(item: .saved)
    }
}
