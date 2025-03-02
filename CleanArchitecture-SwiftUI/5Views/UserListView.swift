//
//  UserListView.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 02/03/2025.
//


import SwiftUI

/// SwiftUI View displaying the list of users.
struct UserListView: View {
    @StateObject var viewModel: UserListViewModel
    @State private var selectedUser: User?
    @State private var isShowingDetail: Bool = false
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                Button(action: {
                    selectedUser = user
                    isShowingDetail = true
                }) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.loadUsers()
            }
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    }
                }
            )
//            .alert(item: $viewModel.errorMessage) { errorMessage in
//                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
//            }
            .background(
                NavigationLink(
                    destination: UserDetailView(
                        viewModel: UserDetailViewModel(
                            user: selectedUser ?? User(
                                id: 0,
                                name: ""
                            ),
                            updateUserUseCase: viewModel.updateUserUseCase
                        ),
                        onSave: { updatedUser in
                            viewModel.updateUser(updatedUser)
                        }),
                    isActive: $isShowingDetail,
                    label: { EmptyView()
 }
                )
                .hidden()
            )
        }
    }
}
