//
//  AuthViewModel.swift
//  Food
//
//  Created by Emir Rassulov on 04/03/2024.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @StateObject var viewModel = AuthViewModel()

    func register(email: String, password: String, name: String, number: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                self.isAuthenticated = false
                self.errorMessage = error.localizedDescription
            } else {
                let user = Auth.auth().currentUser
                let db = Firestore.firestore()

                let userData: [String: Any] = [
                    "name": name,
                    "number": number,
                    
                ]

                db.collection("users").document(user?.uid ?? "").setData(userData) { error in
                    if let error = error {
                        print("Error writing user data to Firestore: \(error)")
                    }
                }

                self.isAuthenticated = true
            }
        }
    }


func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                self.isAuthenticated = false
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                self.isAuthenticated = true
                completion(true)
            }
        }
    }
}
