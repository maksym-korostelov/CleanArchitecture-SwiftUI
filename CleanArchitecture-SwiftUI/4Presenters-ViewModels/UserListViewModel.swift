//
//  UserListViewModel.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 02/03/2025.
//


import Foundation
import Combine

/// ViewModel for the User List View.
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let updateUserUseCase: UpdateUserUseCaseProtocol
    private let getUsersUseCase: GetUsersUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(getUsersUseCase: GetUsersUseCaseProtocol,
         updateUserUseCase: UpdateUserUseCaseProtocol) {
        self.getUsersUseCase = getUsersUseCase
        self.updateUserUseCase = updateUserUseCase
    }

    /// Loads users by executing the getUsersUseCase.
    func loadUsers() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let users = try await getUsersUseCase.execute()
                await MainActor.run {
                    self.users = users
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }

    /// Updates a user after editing.
    func updateUser(_ user: User) {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await updateUserUseCase.execute(user: user)
                await MainActor.run {
                    // Update the user in the local list
                    if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                        self.users[index] = user
                    }
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
