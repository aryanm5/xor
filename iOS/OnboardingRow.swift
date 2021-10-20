//
//  OnboardingRow.swift
//  XOR (iOS
//
//  Created by Aryan Mittal on 10/18/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI

struct OnboardingRow: View {
    
    let item: OnboardingItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            Image(systemName: item.systemImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .padding(8.0)
                .background(item.color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
            VStack(alignment: .leading, spacing: 3.0) {
                Text(item.title)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(item.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 10)
        .listRowBackground(Color(.systemGroupedBackground))
        .hideListRowSeparator()
    }
}


extension View {
    @ViewBuilder
    func hideListRowSeparator() -> some View {
        if #available(iOS 15, *) {
            self.listRowSeparator(.hidden)
        }
        else {
            self
        }
    }
}

struct OnboardingRow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingRow(item: .secure)
    }
}
