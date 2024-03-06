//
//  Validations.swift
//  Food
//
//  Created by Emir Rassulov on 02/02/2024.
//


import Foundation

enum ValidationType {
    case email
    case password
}

enum Validations {
    static func validate(_ type: ValidationType, _ input: String) -> ValidationResult {
        switch type {
        case .email:
            return validateEmail(input)
        case .password:
            return validatePassword(input)
        }
    }

    private static func validateEmail(_ email: String) -> ValidationResult {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        if emailPredicate.evaluate(with: email) {
            return .success
        } else {
            return .failure("Invalid email format")
        }
    }

    private static func validatePassword(_ password: String) -> ValidationResult {
        let minLength = 8

        if password.count >= minLength {
            return .success
        } else {
            return .failure("Password must be at least \(minLength) characters long")
        }
    }
}

enum ValidationResult {
    case success
    case failure(String)

    var isValid: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}
