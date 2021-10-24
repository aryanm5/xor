//
//  OnBoardingView.swift
//  XOR (iOS
//
//  Created by Aryan Mittal on 10/18/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Welcome to XOR")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            HStack {
                Spacer()
                List {
                    OnboardingRow(item: .secure, reverse: false)
                    OnboardingRow(item: .twoway, reverse: true)
                    OnboardingRow(item: .save, reverse: false)
                }
                .disabled(true)
                Spacer()
            }
            
            Button(action: close) {
                Text("Continue")
                    .foregroundColor(Color.white)
                    .fontWeight(.medium)
                    .padding(.vertical, 15)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
            }
            .padding(.bottom, 50)
            .padding(.horizontal, 15)
        }
        .padding(.top, 70)
        .padding(.horizontal, 5)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
    
    private func close() {
        isPresented = false
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isPresented: .constant(true))
    }
}
