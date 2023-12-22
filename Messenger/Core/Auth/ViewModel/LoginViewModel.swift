//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Sebastian on 12/22/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    func login() async throws {
        print("DEBUG: attemping to login user with email \(email)")
        try await AuthServiceImpl().login(withEmail: email, password: password)
    }
}
