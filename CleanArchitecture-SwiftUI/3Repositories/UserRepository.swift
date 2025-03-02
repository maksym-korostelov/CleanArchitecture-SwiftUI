//
//  UserRepository.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 02/03/2025.
//


import Foundation

/// Protocol defining data operations for users.
protocol UserRepositoryProtocol {
    func fetchUsers() async throws -> [User]
    func updateUser(user: User) async throws
}

/// Implementation of UserRepositoryProtocol.
class UserRepository: UserRepositoryProtocol {
    // Simulated data store
    private var users: [User] = [
        User(id: 1, name: "Alice"),
        User(id: 2, name: "Bob"),
        User(id: 3, name: "Charlie")
    ]

    /// Fetches users from the data store.
    func fetchUsers() async throws -> [User] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        return users
    }

    /// Updates a user in the data store.
    func updateUser(user: User) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
        } else {
            throw NSError(domain: "User not found", code: 404, userInfo: nil)
        }
    }
}
