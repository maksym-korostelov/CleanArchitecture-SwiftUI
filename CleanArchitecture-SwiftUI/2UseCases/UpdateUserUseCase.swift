//
//  UpdateUserUseCase.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 02/03/2025.
//


import Foundation

/// Protocol defining the use case for updating a user.
protocol UpdateUserUseCaseProtocol {
    func execute(user: User) async throws
}

/// Implementation of the use case for updating a user.
class UpdateUserUseCase: UpdateUserUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    /// Executes the use case to update a user.
    func execute(user: User) async throws {
        try await repository.updateUser(user: user)
    }
}
