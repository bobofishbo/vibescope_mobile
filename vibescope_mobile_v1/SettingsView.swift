//
//  SettingsView.swift
//  vibescope_mobile_v1
//
//  Created by Andrew131 on 2025/2/8.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("⚙️ Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button(action: {
                print("🔴 User Signed Out")
            }) {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
