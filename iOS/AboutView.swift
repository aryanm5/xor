//
//  AboutView.swift
//  CyberCipher (iOS)
//
//  Created by Aryan Mittal on 10/17/21.
//  Copyright © 2021 MittalDev. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                
                Text("CyberCipher is a text encryption tool that uses the XOR binary operation to encrypt messages using a secret key. The result can only be decrypted with the same key. This can be used to send secret messages, encrypt text, or store passwords.")
                    .padding()
                
                Text("Get started by encrypting some text, sending it to a friend, and letting them decrypt it.")
                    .padding()
                
                HStack {
                    Text("Aryan Mittal")
                        .font(Font.title3.weight(.semibold))
                        .padding(.top)
                }
                .frame(maxWidth: .infinity)
                
                Text("Along with writing for his high school's newspaper, Aryan enjoys playing tennis with his friends and developing apps for his community. Check out some of his other projects at [mittaldev.com](https://mittaldev.com).")
                    .padding()
            }
            .navigationTitle("About the App")
            .navigationBarTitleDisplayMode(.inline)
            Spacer()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
