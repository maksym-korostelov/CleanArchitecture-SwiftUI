//
//  CleanArchitecture_SwiftUIApp.swift
//  CleanArchitecture-SwiftUI
//
//  Created by Maksym Korostelov on 01/03/2025.
//

import SwiftUI

@main
struct CleanArchitecture_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = UserRepository()
            let getUsersUseCase = GetUsersUseCase(repository: repository)
            let updateUserUseCase = UpdateUserUseCase(repository: repository)
            let userListViewModel = UserListViewModel(getUsersUseCase: getUsersUseCase,
                                                      updateUserUseCase: updateUserUseCase)
            UserListView(viewModel: userListViewModel)
        }
    }
}
