//
//  UserDetailView.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 02/03/2025.
//


import SwiftUI

/// SwiftUI View for editing a user's details.
struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    let onSave: (User) -> Void

    var body: some View {
        Form {
            TextField("Name", text: $viewModel.userName)
                .autocapitalization(.words)
        }
        .navigationTitle("Edit User")
        .navigationBarItems(trailing: Button("Save") {
            Task { @MainActor in
                let success = await viewModel.saveUser()
                if success {
                    presentationMode.wrappedValue.dismiss()
                    onSave(User(id: viewModel.user.id, name: viewModel.userName))
                }
            }
        })
//        .alert(item: $viewModel.errorMessage) { errorMessage in
//            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
//        }
        .overlay(
            Group {
                if viewModel.isSaving {
                    ProgressView("Saving...")
                }
            }
        )
    }
}
