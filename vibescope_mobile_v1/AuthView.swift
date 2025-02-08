//
//  AuthView 2.swift
//  vibescope_mobile_v1
//
//  Created by XIE BO on 2025/2/8.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Sign Up or Sign In", selection: $viewModel.authAction) {
                    ForEach(AuthAction.allCases, id: \.rawValue) { action in
                        Text(action.rawValue).tag(action)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        Task {
                            try await viewModel.authorize()
                            await viewModel.isUserAuthenticated()
                            if viewModel.isAuthenticated {
                                await MainActor.run {
                                    dismiss()
                                }
                            }
                        }
                        
                    } label: {
                        Text(viewModel.authAction.rawValue)
                    }
                }
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(viewModel: ViewModel())
    }
}
