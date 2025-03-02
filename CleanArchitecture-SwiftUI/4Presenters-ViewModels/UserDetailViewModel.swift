//
//  UserDetailViewModel.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 02/03/2025.
//


import Foundation

/// ViewModel for the User Detail View.
class UserDetailViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var isSaving: Bool = false
    @Published var errorMessage: String?

    private let updateUserUseCase: UpdateUserUseCaseProtocol
    var user: User

    init(user: User, updateUserUseCase: UpdateUserUseCaseProtocol) {
        self.user = user
        self.userName = user.name
        self.updateUserUseCase = updateUserUseCase
    }

    /// Saves the updated user.
    func saveUser() async -> Bool {
        isSaving = true
        errorMessage = nil

        user.name = userName

        do {
            try await updateUserUseCase.execute(user: user)
            isSaving = false
            return true
        } catch {
            errorMessage = error.localizedDescription
            isSaving = false
            return false
        }
    }
}
