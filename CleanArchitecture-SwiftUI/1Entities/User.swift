//
//  User.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 02/03/2025.
//


import Foundation

/// User is the domain model representing a user.
/// Conforms to Identifiable for SwiftUI lists and Equatable for comparisons.
struct User: Identifiable, Equatable {
    let id: Int
    var name: String
}
