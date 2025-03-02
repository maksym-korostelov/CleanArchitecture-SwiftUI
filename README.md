Explanation of Key Components
  
  Async/Await Usage
  
    Repository Methods: Use async throws to simulate asynchronous data operations.
    ViewModels: Use Task and await to perform asynchronous operations.
    Views: Initiate asynchronous tasks using Task in event handlers.

  Combine Usage
  
    ViewModels: Use @Published properties to notify the SwiftUI views of state changes.
    Views: Observe @Published properties via property wrappers like @StateObject and @ObservedObject.

Dependency Injection

  Use Cases: Receive repositories via initializer injection.
  ViewModels: Receive use cases via initializer injection.
  Views: Receive view models via initializer injection.
  App Entry Point: Assembles and injects dependencies.
  
Data Flow

UserListViewModel calls loadUsers():

  Executes getUsersUseCase.execute().
  The use case calls repository.fetchUsers().
  The repository simulates fetching users.
  The view model updates users, triggering the view to display them.
  
User selects a user:

UserListView sets selectedUser and isShowingDetail to present UserDetailView.
User edits and saves:

UserDetailViewModel updates userName.
On save, saveUser() is called.
Executes updateUserUseCase.execute(user:).
The repository simulates updating the user.
On success, onSave closure is called in UserListView, passing the updated user.
UserListViewModel updates the user:

updateUser(_:) updates the user locally and calls updateUserUseCase.
The users array is updated, and the changes reflect in the UI.
Error Handling
Errors are caught and errorMessage is updated in view models.
Views observe errorMessage and present alerts when errors occur.
Loading Indicators
isLoading and isSaving properties are used to display ProgressView overlays.
