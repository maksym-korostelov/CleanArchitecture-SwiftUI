//
//  FetchUsersUseCase.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 02/03/2025.
//


import Foundation

/// Protocol defining the use case for fetching users.
protocol GetUsersUseCaseProtocol {
    func execute() async throws -> [User]
}

/// Implementation of the use case for fetching users.
class GetUsersUseCase: GetUsersUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    /// Executes the use case to fetch users.
    func execute() async throws -> [User] {
        try await repository.fetchUsers()
    }
}
