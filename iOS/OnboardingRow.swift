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
    let reverse: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 0.0) {
            Image(systemName: item.systemImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 26, height: 26)
                .padding(13.0)
                .background(item.color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
            
            VStack(alignment: reverse ? .trailing : .leading, spacing: 3.0) {
                Text(item.title)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .multilineTextAlignment(reverse ? .trailing : .leading)
                
                Text(item.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(reverse ? .trailing : .leading)
            }
            .padding(.leading, 20)
        }
        .padding(.vertical, 22)
        .listRowBackground(Color(.systemGroupedBackground))
        .environment(\.layoutDirection, reverse ? .rightToLeft : .leftToRight)
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
        OnboardingRow(item: .save, reverse: false)
    }
}
