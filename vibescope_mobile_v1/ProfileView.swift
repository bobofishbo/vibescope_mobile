//
//  ProfileView.swift
//  vibescope_mobile_v1
//
//  Created by XIE BO on 2025/2/8.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var userInfo: HomeUserInfo?
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let error = errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            }

            if let info = userInfo {
                VStack(alignment: .leading) {
                    Text("👤 Welcome, \(info.user_name)")
                        .font(.title2)
                        .bold()

                    Text("🏠 Your Group: \(info.group_name)")
                        .font(.headline)
                        .padding(.top, 5)

                    Text("👥 Other Members:")
                        .font(.subheadline)
                        .bold()

                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(info.other_members, id: \.self) { member in
                            Text("- \(member)")
                        }
                    }
                    .padding(.top, 5)
                }
                .padding()
            } else {
                ProgressView("Loading...")
            }
        }
        .task {
            await fetchUserInfo()
        }
    }

    func fetchUserInfo() async {
        do {
            let response = try await supabase
                .from("user_group_info") // ✅ Supabase View
                .select()
                .execute()

            let decodedData = try JSONDecoder().decode([HomeUserInfo].self, from: response.data)
            if let firstResult = decodedData.first {
                DispatchQueue.main.async {
                    self.userInfo = firstResult
                    self.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "No group data found"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    ProfileView(viewModel: ViewModel())
}
