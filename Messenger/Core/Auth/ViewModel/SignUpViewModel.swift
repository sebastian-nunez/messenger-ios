import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""

    func createUser() async throws {
        print("DEBUG: attemping to create user with email \(email)")
        try await AuthServiceImpl().createUser(withEmail: email, password: password, fullname: fullname)
    }
}
