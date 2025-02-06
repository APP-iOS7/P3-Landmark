//
//  AuthViewModel.swift
//  FirebaseAuth
//
//  Created by 김덕원 on 2/5/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthManager: ObservableObject {
    
    @Published var user: User?
    
    static let shared = AuthManager()
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    // Sign in
    @MainActor
    func signIn(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.user = result.user
    }
    
    // Sign Up
    @MainActor
    func signUp(email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = result.user
        
        if let userEmail = user.email {
            try await Firestore.firestore().collection("users").document(user.uid).setData([
                "email": userEmail,
                "joinDate": Timestamp(date: Date.now)
            ])
        }
        
        // Updating the User
        self.user = user
    }
    
    // Reset Password
    @MainActor
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    //Log Out
    @MainActor
    func logout() {
        try? Auth.auth().signOut()
        self.user = nil
    }
}

enum AuthStyle: String {
    case signIn = "Sign In"
    case signUp = "Sign Up"
}
